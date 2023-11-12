import 'dart:convert';
import 'package:dio/dio.dart';
import 'end_point.dart';

class EndpointFirebaseProvider implements EndPoint {
  final Dio client;

  EndpointFirebaseProvider(this.client);

  @override
  Future<Map<String, dynamic>> fetchExpenses() async {
    try {
      final response = await client.get('/expenses.json');
      return json.decode(response.toString());
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  @override
  Future postExpense(expenseData) async {
    try {
      await client.post(
        '/expenses.json',
        data: json.encode(expenseData),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteExpense(expenseId) async {
    try {
      await client.delete(
        '/expenses/$expenseId.json',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateExpense(expenseId, updatedData) async {
    try {
      await client.put(
        '/expenses/$expenseId.json',
        data: updatedData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> searchExpense(query) async {
    try {
      final response = await client.get(
          '/expenses.json?orderBy="name"&startAt="$query"&endAt="$query\uf8ff"');

      return json.decode(response.toString());
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
