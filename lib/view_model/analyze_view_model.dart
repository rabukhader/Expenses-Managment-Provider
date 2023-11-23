import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/expense.dart';

class AnalyzeViewModel extends ChangeNotifier{
  
  Map<String, double> classifyExpensesByMonth(
      List<Expense> expenses, List<String> months) {
    final Map<String, double> monthlyExpenses = {};

    for (final monthName in months) {
      monthlyExpenses[monthName] = 0.0;
    }

    for (final expense in expenses) {
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

  int totalExpenses(List<Expense> expenses) {
    int totalExpenses = 0;

    for (var element in expenses) {
      totalExpenses += element.total!;
    }

    return totalExpenses;
  }

  double averageExpenses(List<Expense> expenses) {
    int totalExpenses = 0;
    int count = 0;

    for (var element in expenses) {
      totalExpenses += element.total!;
      count++;
    }
    if (count == 0) {
      count = 1;
    }
    double avgExpenses = totalExpenses / count;

    return avgExpenses;
  }

  int minExpense(List<Expense> expenses) {
    if (expenses.isNotEmpty) {
      int minExpense = 9999999999999;
      for (var element in expenses) {
        if (element.total! < minExpense) {
          minExpense = element.total!;
        }
      }
      return minExpense;
    } else {
      return 0;
    }
  }

  int maxExpense(List<Expense> expenses) {
    if (expenses.isNotEmpty) {
      int maxExpense = -9999999999999;
      for (var element in expenses) {
        if (element.total! > maxExpense) {
          maxExpense = element.total!;
        }
      }
      return maxExpense;
    } else {
      return 0;
    }
  }
}