import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:expenses_managment_app_provider/model/data/local_changes.dart';
import 'package:flutter/material.dart';
import '../model/entities/expense_entity.dart';
import '../model/data/expense_model.dart';
import '../repositry/local_db/db_helper.dart';

class ManageExpensesViewModel with ChangeNotifier {
  ConnectivityResult currentConnectivity = ConnectivityResult.none;
  StreamController<Map<String, Expense>> dataStream =
      StreamController<Map<String, Expense>>.broadcast();
  StreamController<String> textStream = StreamController.broadcast();
  Completer<void>? searchCompleter;
  CancelToken? cancelToken;
  ExpenseModel expenseModel = ExpenseModel.instance;
  LocalChangesModel localChanges = LocalChangesModel.instance;

  ManageExpensesViewModel() {
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
      Map<String, Expense> data = await expenseModel.fetchExpense();
      dataStream.add(data);
      return data;
    } else {
      await fetchLocalExpenses();
    }
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        await fetchExpenses();
      }
    });
    notifyListeners();
  }

  Future fetchLocalExpenses() async {
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
      await expenseModel.deleteExpense(id);
    } else {
      await deleteLocalExpense(id);
    }
    await fetchExpenses();
    notifyListeners();
  }

  Future<void> editExpense(updatedData, id) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      expenseModel.editExpense(updatedData, id);
    } else {
      await editLocalExpense(updatedData, id);
    }
    await fetchExpenses();
    notifyListeners();
  }

  Future<void> addExpense(newExpense) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      await expenseModel.postExpense(newExpense);
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
    dataStream.add(expenseModel.searchResults);
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

  // Future<Map<String, dynamic>> fetchDataById(String id) async {
  //   final url =
  //       'https://providerrest-default-rtdb.firebaseio.com/expenses/$id.json';

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     rethrow;
  //   }
  // }
}
