import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:expenses_managment_app_provider/model/entities/expense.dart';
import 'package:flutter/material.dart';
import '../model/apis/custom_client.dart';
import '../model/apis/end_point_firebase.dart';
import '../model/expense_model.dart';
import '../model/local_db/db_helper.dart';
import '../model/local_db/local_expense_change.dart';

Dio client = Client().init();
EndpointFirebaseProvider api = EndpointFirebaseProvider(client);
ConnectivityResult currentConnectivity = ConnectivityResult.none;

class ExpensesViewModel with ChangeNotifier {
  StreamController<String> textStream = StreamController.broadcast();
  StreamController<Map<String, Expense>> dataStream =
      StreamController<Map<String, Expense>>.broadcast();
  Completer<void>? searchCompleter;
  CancelToken? cancelToken;
  ExpenseModel expenseModel = ExpenseModel();

  List<LocalExpenseChange> localChanges = [];

  void disposeStreams() {
    textStream.close();
    dataStream.close();
  }

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
      dataStream.add(expenseModel.searchResults);
    } else {
      await fetchLocalExpenses();
    }

    Connectivity().onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        await fetchExpenses();
      }
    });
  }

  Future<void> fetchLocalExpenses() async {
    final dbHelper = DBHelper.instance;
    final localData = await dbHelper.fetchExpenses();
    expenseModel.allExpenses = localData;
    expenseModel.searchResults = expenseModel.allExpenses;
    dataStream.add(expenseModel.searchResults);
    notifyListeners();
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

    localChanges.add(LocalExpenseChange(id: id, changes: {'deleted': true}));
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

    localChanges
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

    localChanges.add(
        LocalExpenseChange(id: newExpense.name, changes: {'new': newExpense}));
    await dbHelper.syncLocalChangesWithApi();
    notifyListeners();
  }

  Future<void> syncLocalChangesWithApi() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      if (localChanges.isEmpty) {
        return;
      }

      for (var localChange in localChanges) {
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

    localChanges.clear();
  }
}
