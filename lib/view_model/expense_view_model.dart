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
  Map<String, Expense> searchResults = {};
  Map<String, Expense> allExpenses = {};

  Future fetchExpenses() async {
    final response = await api.fetchExpenses();
    Map<String, Expense> data = response.map((key, value) {
      return MapEntry(key, Expense.fromJson(value));
    });
    allExpenses = data;
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
    final response = await api.searchExpense(query);
    print(response);
    if (query.isNotEmpty) {
      searchResults = response.map((key, value) {
        return MapEntry(key, Expense.fromJson(value));
      });
    } else {
      searchResults.clear();
    }
    notifyListeners();
  }
}
