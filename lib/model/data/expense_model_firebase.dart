import 'dart:async';

import 'package:dio/dio.dart';
import '../../repositry/local_db/db_helper.dart';
import '../entities/expense_entity.dart';
import '../../repositry/firebase/end_point_firebase.dart';
import '../../repositry/dio/custom_client.dart';

Dio client = Client().init();
EndpointFirebaseProvider api = EndpointFirebaseProvider(client);

class ExpenseModelFirebase {
  ExpenseModelFirebase._();
  static final ExpenseModelFirebase _instance = ExpenseModelFirebase._();

  static ExpenseModelFirebase get instance => _instance;

  Map<String, Expense> allExpenses = {};
  Map<String, Expense> searchResults = {};

  Future fetchExpenses() async {
    try {
      final response = await api.fetchExpenses();
      Map<String, Expense> data = response.map((key, value) {
        return MapEntry(key, Expense.fromMap(value));
      });
      final dbHelper = DBHelper.instance;
      await dbHelper.clearData();
      await dbHelper.postExpense(data);

      allExpenses = data;
      searchResults = data;
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future postExpense(newExpense) async {
    try {
      await api.postExpense(newExpense);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteExpense(id) async {
    try {
      await api.deleteExpense(id);
    } catch (e) {
      rethrow;
    }
  }

  Future editExpense(updatedData, id) async {
    try {
      await api.updateExpense(id, updatedData);
    } catch (e) {
      rethrow;
    }
  }
}
