import 'package:expenses_managment_app_provider/model/data/expense_model_supabase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/entities/expense_entity.dart';
import '../utils/months.dart';

class AnalyzeViewModel with ChangeNotifier {
  ExpenseModelSupabase expenseModel = ExpenseModelSupabase.instance;
  Map<String, double> classifyExpensesByMonth() {
    final Map<String, double> monthlyExpenses = {};

    for (final monthName in months) {
      monthlyExpenses[monthName] = 0.0;
    }

    for (final expense in expenseModel.allExpenses.values.toList()) {
      final DateTime expenseDate =
          DateFormat('yyyy-MM-dd').parse(expense.dueDate);
      final String monthName = DateFormat('MMMM').format(expenseDate);
      if (monthlyExpenses.containsKey(monthName)) {
        final double? currentTotal = monthlyExpenses[monthName];
        if (currentTotal != null) {
          monthlyExpenses[monthName] = currentTotal + expense.total!;
        }
      }
    }

    return monthlyExpenses;
  }

  int totalExpenses() {
    int totalExpenses = 0;

    for (var element in expenseModel.allExpenses.values.toList()) {
      totalExpenses += element.total!;
    }

    return totalExpenses;
  }

  String averageExpenses() {
    int totalExpenses = 0;
    int count = 0;

    for (var element in expenseModel.allExpenses.values.toList()) {
      totalExpenses += element.total!;
      count++;
    }
    if (count == 0) {
      count = 1;
    }
    double avgExpenses = totalExpenses / count;
    String avg;
    if (avgExpenses.toString().length > 6) {
      avg = avgExpenses.toString().substring(0, 6);
    } else {
      avg = avgExpenses.toString();
    }

    return avg;
  }

  int minExpense() {
    if (expenseModel.allExpenses.values.toList().isNotEmpty) {
      int minExpense = 9999999999999;
      for (var element in expenseModel.allExpenses.values.toList()) {
        if (element.total! < minExpense) {
          minExpense = element.total!;
        }
      }
      return minExpense;
    } else {
      return 0;
    }
  }

  int maxExpense() {
    if (expenseModel.allExpenses.values.toList().isNotEmpty) {
      int maxExpense = -9999999999999;
      for (var element in expenseModel.allExpenses.values.toList()) {
        if (element.total! > maxExpense) {
          maxExpense = element.total!;
        }
      }
      return maxExpense;
    } else {
      return 0;
    }
  }

  Map<String, Expense> fetchExpenseByMonth(monthIndex) {
    var classifiedExpenses = classifyExpensesByMonth();

    if (monthIndex >= 0 && monthIndex < classifiedExpenses.length) {
      var selectedMonth = classifiedExpenses.keys.toList()[monthIndex];
      var expensesForMonth = expenseModel.allExpenses.values
          .where((expense) =>
              DateFormat('MMMM')
                  .format(DateFormat('yyyy-MM-dd').parse(expense.dueDate)) ==
              selectedMonth)
          .toList();

      Map<String, Expense> expenseMap = {};
      for (var expense in expensesForMonth) {
        expenseMap[expense.name] = expense;
      }

      return expenseMap;
    }

    return {};
  }
}
