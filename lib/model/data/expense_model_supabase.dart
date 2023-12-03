import 'package:dio/dio.dart';
import 'package:expenses_managment_app_provider/model/entities/expense_entity.dart';
import 'package:expenses_managment_app_provider/repositry/supabase/end_point_supabase.dart';

import '../../repositry/local_db/db_helper.dart';

class ExpenseModelSupabase {
  ExpenseModelSupabase._();
  static final ExpenseModelSupabase _instance = ExpenseModelSupabase._();

  static ExpenseModelSupabase get instance => _instance;

  Map<String, Expense> allExpenses = {};
  Map<String, Expense> searchResults = {};

  EndPointSupabase endPoint = EndPointSupabase();

  Future fetchExpenses() async {
    try {
      final response = await endPoint.fetchExpenses();
      Map<String, Expense> data = {
        for (var item in response)
          item['id']: Expense.fromMap({
            'name': item['name'],
            'total': item['total'],
            'dueDate': item['dueDate'],
            'imageUrl': item['imageUrl'],
            'address': item['address'],
          })
      };
      final dbHelper = DBHelper.instance;
      await dbHelper.clearData();
      await dbHelper.postExpense(data);

      allExpenses = data;
      searchResults = data;
      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future postExpense(newExpense) async {
    try {
      await endPoint.postExpense(newExpense);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteExpense(id) async {
    try {
      await endPoint.deleteExpense(id);
    } catch (e) {
      rethrow;
    }
  }

  Future editExpense(updatedData, id) async {
    try {
      await endPoint.updateExpense(id, updatedData);
    } catch (e) {
      rethrow;
    }
  }

  Future searchExpense(query, {CancelToken? cancelToken}) async {
    try {
      final response =
          await endPoint.searchExpense(query, cancelToken: cancelToken);
          
      if (response != []) {
        Map<String, Expense> data = {
          for (var item in response)
            item['id']: Expense.fromMap({
              'name': item['name'],
              'total': item['total'],
              'dueDate': item['dueDate'],
              'imageUrl': item['imageUrl'],
              'address': item['address'],
            })
        };
        return data;
      }
      return {};
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
