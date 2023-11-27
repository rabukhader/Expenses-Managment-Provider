import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:expenses_managment_app_provider/model/data/local_changes.dart';
import 'package:flutter/material.dart';
import '../repositry/Dio/custom_client.dart';
import '../repositry/apis/end_point_firebase.dart';
import '../model/data/expense_model.dart';
import '../repositry/local_db/db_helper.dart';
import 'package:http/http.dart' as http;

Dio client = Client().init();
EndpointFirebaseProvider api = EndpointFirebaseProvider(client);
ConnectivityResult currentConnectivity = ConnectivityResult.none;

class ExpensesViewModel with ChangeNotifier {
  StreamController<Map<String, Expense>> dataStream =
      StreamController<Map<String, Expense>>.broadcast();
  StreamController<String> textStream = StreamController.broadcast();
  Completer<void>? searchCompleter;
  CancelToken? cancelToken;
  ExpenseModel expenseModel = ExpenseModel.instance;
  LocalChangesModel localChanges = LocalChangesModel.instance;

  ExpensesViewModel() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (currentConnectivity != result) {
        currentConnectivity = result;
        if (result != ConnectivityResult.none) {
          syncLocalChangesWithApi();
        }
      }
    });
  }

  Future fetchExpenses() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      final response = await api.fetchExpenses();
      Map<String, Expense> data = response.map((key, value) {
        return MapEntry(key, Expense.fromMap(value));
      });
      final dbHelper = DBHelper.instance;
      await dbHelper.clearData();
      await dbHelper.postExpense(data);

      expenseModel.allExpenses = data;
      expenseModel.searchResults = data;
      dataStream.add(data);
    } else {
      await fetchLocalExpenses();
    }

    Connectivity().onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        await fetchExpenses();
      }
    });
  }

  Future fetchLocalExpenses() async {
    final dbHelper = DBHelper.instance;
    final localData = await dbHelper.fetchExpenses();
    expenseModel.allExpenses = localData;
    expenseModel.searchResults = expenseModel.allExpenses;
    return expenseModel.searchResults;
  }

  Future<void> deleteExpense(id) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      await api.deleteExpense(id);
    } else {
      await deleteLocalExpense(id);
    }
    await fetchExpenses();
    notifyListeners();
  }

  Future<void> editExpense(updatedData, id) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      await api.updateExpense(id, updatedData);
    } else {
      await editLocalExpense(updatedData, id);
    }
    await fetchExpenses();
    notifyListeners();
  }

  Future<void> addExpense(newExpense) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      await api.postExpense(newExpense);
    } else {
      await addLocalExpense(newExpense);
    }
    await fetchExpenses();
    notifyListeners();
  }

  Future searchExpense(String query) async {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("Cancelled");
    }
    cancelToken = CancelToken();

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      final response = await api.searchExpense(query, cancelToken: cancelToken);
      if (query.isNotEmpty) {
        expenseModel.searchResults = response.map((key, value) {
          return MapEntry(key, Expense.fromMap(value));
        });
      } else {
        expenseModel.searchResults = expenseModel.allExpenses;
      }
    } else {
      final dbHelper = DBHelper.instance;
      final offlineResults = await dbHelper.searchExpenses(query);
      expenseModel.searchResults = {for (var e in offlineResults) e.name: e};
    }

    notifyListeners();
  }

  Future<void> deleteLocalExpense(id) async {
    final dbHelper = DBHelper.instance;
    await dbHelper.deleteExpense(id);

    localChanges.listOfLocalChanges
        .add(LocalExpenseChange(id: id, changes: {'deleted': true}));
    await dbHelper.syncLocalChangesWithApi();

    notifyListeners();
  }

  Future<void> editLocalExpense(updatedData, id) async {
    final dbHelper = DBHelper.instance;
    Map<String, Object?> data = {
      'name': updatedData.name,
      'total': updatedData.total,
      'address': updatedData.address,
      'imageUrl': updatedData.imageUrl,
      'dueDate': updatedData.dueDate
    };
    await dbHelper.updateExpense(id, data);

    localChanges.listOfLocalChanges
        .add(LocalExpenseChange(id: id, changes: {'edited': updatedData}));

    await dbHelper.syncLocalChangesWithApi();
    notifyListeners();
  }

  Future<void> addLocalExpense(newExpense) async {
    final dbHelper = DBHelper.instance;
    final String uniqueId =
        '${newExpense.name}_${DateTime.now().millisecondsSinceEpoch}';

    final Map<String, Expense> newE = {uniqueId: newExpense};
    await dbHelper.postExpense(newE);

    localChanges.listOfLocalChanges.add(
        LocalExpenseChange(id: newExpense.name, changes: {'new': newExpense}));
    await dbHelper.syncLocalChangesWithApi();
    notifyListeners();
  }

  Future<void> syncLocalChangesWithApi() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      if (localChanges.listOfLocalChanges.isEmpty) {
        return;
      }

      for (var localChange in localChanges.listOfLocalChanges) {
        if (localChange.changes.containsKey('deleted')) {
          await api.deleteExpense(localChange.id);
        } else if (localChange.changes.containsKey('edited')) {
          await api.updateExpense(
              localChange.id, localChange.changes['edited']);
        } else {
          await api.postExpense(localChange.changes['new']);
        }
      }
    }

    localChanges.listOfLocalChanges.clear();
  }

  onSearch(text) {
    textStream.add(text);
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchDataById(String id) async {
    final url =
        'https://providerrest-default-rtdb.firebaseio.com/expenses/$id.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
