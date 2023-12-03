import 'package:dio/dio.dart';
import 'package:expenses_managment_app_provider/repositry/firebase/end_point.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EndPointSupabase implements EndPoint {
  final supabase = Supabase.instance.client;
  final tableName = 'expenses';

  @override
  Future fetchExpenses() async {
    try {
      final response = await supabase.from(tableName).select('*');
      return response;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  @override
  Future<void> deleteExpense(expenseId) async {
    try {
      await supabase.from(tableName).delete().eq('id', expenseId);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future postExpense(expenseData) async {
    try {
      await supabase.from(tableName).insert(expenseData);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future updateExpense(expenseId, updatedData) async {
    try {
      Map<String, dynamic> dataToUpdate = {
        'id': expenseId,
        ...updatedData.toJson()
      };
      await supabase
          .from(tableName)
          .upsert([dataToUpdate], ignoreDuplicates: false).eq('id', expenseId);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future searchExpense(String query,{CancelToken? cancelToken}) async{
    try {
      final response = await supabase.from(tableName).select('*').ilike('name','%$query%');
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
