import 'dart:async';
import 'package:dio/dio.dart';
import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:flutter/material.dart';
import '../model/apis/custom_client.dart';
import '../model/apis/end_point_firebase.dart';

Dio client = Client().init();
EndpointFirebaseProvider api = EndpointFirebaseProvider(client);

class ExpensesViewModel with ChangeNotifier {
  StreamController<String> textStream = StreamController.broadcast();
  StreamController dataStream = StreamController.broadcast();
  Map<String, Expense> searchResults = {};
  Map<String, Expense> allExpenses = {};
  Completer<void>? searchCompleter;
  CancelToken? cancelToken; // To manage request cancellation

  Future fetchExpenses() async {
    final response = await api.fetchExpenses();
    Map<String, Expense> data = response.map((key, value) {
      return MapEntry(key, Expense.fromJson(value));
    });
    allExpenses = data;
    searchResults = data;
    dataStream.add(searchResults);
    return data;
  }

  Future<void> deleteExpense(id) async {
    await api.deleteExpense(id);
    notifyListeners();
  }

  Future<void> editExpense(updatedData, id) async {
    await api.updateExpense(id, updatedData);
    notifyListeners();
  }

  Future<void> addExpense(newExpense) async {
    await api.postExpense(newExpense);
    notifyListeners();
  }

  Future searchExpense(String query) async {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("Cancelled");
    }
    cancelToken = CancelToken();

    final response = await api.searchExpense(query, cancelToken: cancelToken);
    if (query.isNotEmpty) {
      searchResults = response.map((key, value) {
        return MapEntry(key, Expense.fromJson(value));
      });
    } else {
      searchResults = allExpenses;
    }
    notifyListeners();
  }

}
