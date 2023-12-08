import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:expenses_managment_app_provider/model/data/local_changes.dart';
import 'package:expenses_managment_app_provider/model/services/analytics/analytics.dart';
import 'package:flutter/material.dart';
import '../model/data/expense_model_supabase.dart';
import '../model/entities/expense_entity.dart';
import '../repositry/local_db/db_helper.dart';

class ManageExpensesViewModel with ChangeNotifier {
  ConnectivityResult currentConnectivity = ConnectivityResult.none;
  StreamController<String> textStream = StreamController.broadcast();
  TextEditingController textController = TextEditingController();
  Completer<void>? searchCompleter;
  CancelToken? cancelToken;
  ExpenseModelSupabase expenseModel = ExpenseModelSupabase.instance;
  LocalChangesModel localChanges = LocalChangesModel.instance;
  Analytics analytics = Analytics();

  ManageExpensesViewModel() {
    expenseModel.searchResults = expenseModel.allExpenses;
    textController.addListener(() {
      textStream.add(textController.text);
    });
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (currentConnectivity != result) {
        currentConnectivity = result;
        if (result != ConnectivityResult.none) {
          await syncLocalChangesWithApi();
        }
      }
    });
  }

  Future fetchExpenses() async {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("Cancelled");
    }
    cancelToken = CancelToken();

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Map<String, Expense> data = await expenseModel.fetchExpenses();
      return data;
    } else {
      await fetchLocalExpenses();
    }
    notifyListeners();
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
  }

  Future<void> editExpense(updatedData, id) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      await expenseModel.editExpense(updatedData, id);
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
    analytics.createPurchaseEvent();
    await analytics.purchaseEventGoogle();
    notifyListeners();
  }

  Future searchExpense(String query) async {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("Cancelled");
    }
    cancelToken = CancelToken();

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      final response =
          await expenseModel.searchExpense(query, cancelToken: cancelToken);
      if (query.isNotEmpty) {
        expenseModel.searchResults = response;
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
    notifyListeners();
  }

  Future<void> syncLocalChangesWithApi() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      if (localChanges.listOfLocalChanges.isEmpty) {
        return;
      }

      List<LocalExpenseChange> copyOfLocalChanges =
          List.from(localChanges.listOfLocalChanges);

      for (var localChange in copyOfLocalChanges) {
        try {
          if (localChange.changes.containsKey('deleted')) {
            await expenseModel.deleteExpense(localChange.id);
          } else if (localChange.changes.containsKey('edited')) {
            print(localChange.changes['edited']);
            await expenseModel.editExpense(
                localChange.changes['edited'], localChange.id);
          } else {
            await expenseModel.postExpense(localChange.changes['new']);
          }
          localChanges.listOfLocalChanges.remove(localChange);
        } catch (error) {
          print('Error syncing change with API: $error');
        }
      }
    }

    localChanges.listOfLocalChanges.clear();
    notifyListeners();
  }

  void onSearch(text) {
    textStream.add(text);
    notifyListeners();
  }
}
