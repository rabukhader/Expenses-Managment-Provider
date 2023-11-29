import 'package:dio/dio.dart';
import '../../repositry/local_db/db_helper.dart';
import '../entities/expense_entity.dart';
import '../../repositry/apis/end_point_firebase.dart';
import '../../repositry/dio/custom_client.dart';

Dio client = Client().init();
EndpointFirebaseProvider api = EndpointFirebaseProvider(client);

class ExpenseModel {
  ExpenseModel._();
  static final ExpenseModel _instance = ExpenseModel._();

  static ExpenseModel get instance => _instance;

  Map<String, Expense> allExpenses = {};
  Map<String, Expense> searchResults = {};

  Future postExpense(newExpense) async {
    await api.postExpense(newExpense);
  }

  Future fetchExpense() async {
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
  }

  Future deleteExpense(id) async {
    await api.deleteExpense(id);
  }

  Future editExpense(updatedData, id) async {
    await api.updateExpense(id, updatedData);
  }
}
