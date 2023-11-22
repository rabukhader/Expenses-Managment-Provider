import 'dart:async';
import 'package:dio/dio.dart';
import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:flutter/material.dart';
import '../model/apis/custom_client.dart';
import '../model/apis/end_point_firebase.dart';
import '../model/local_db/db_helper.dart';

Dio client = Client().init();
EndpointFirebaseProvider api = EndpointFirebaseProvider(client);

class ExpensesViewModel with ChangeNotifier {
  StreamController<String> textStream = StreamController.broadcast();
  StreamController<Map<String, Expense>> dataStream =
      StreamController<Map<String, Expense>>.broadcast();
  Map<String, Expense> searchResults = {};
  Map<String, Expense> allExpenses = {};
  Completer<void>? searchCompleter;
  CancelToken? cancelToken;

Future fetchExpenses() async {
  try {
    final response = await api.fetchExpenses();
    Map<String, Expense> data = response.map((key, value) {
      return MapEntry(key, Expense.fromJson(value));
    });
    final dbHelper = DBHelper.instance;
    await dbHelper.insertData(data.values.toList());

    allExpenses = data;
    searchResults = data;
    dataStream.add(searchResults);
  } catch (error) {
    print('Error fetching expenses: $error');
    
    final dbHelper = DBHelper.instance;
    final localData = await dbHelper.getData();

    allExpenses = Map.fromIterable(localData, key: (item) => item.name);
    searchResults = allExpenses;
    dataStream.add(searchResults);
  }
}


  Future<void> deleteExpense(id) async {
    await api.deleteExpense(id);
    await fetchExpenses();
    notifyListeners();
  }

  Future<void> editExpense(updatedData, id) async {
    await api.updateExpense(id, updatedData);
    await fetchExpenses();

    notifyListeners();
  }

  Future<void> addExpense(newExpense) async {
    await api.postExpense(newExpense);
    await fetchExpenses();

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
