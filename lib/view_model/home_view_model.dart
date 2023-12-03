import 'dart:async';
import 'package:expenses_managment_app_provider/model/data/expense_model_supabase.dart';
import 'package:expenses_managment_app_provider/model/data/user_model_supabase.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  UserModelSupabase userModel = UserModelSupabase.instance;
  ExpenseModelSupabase expenseModel = ExpenseModelSupabase.instance;

  Future fetchExpenses() async {
    await expenseModel.fetchExpenses();
  }

  List loadUserInfo() {
    final data = userModel.getUserInfo();
    return data;
  }

  Future<bool> signOut() async {
    try {
      bool success = await userModel.signOut();
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      return false;
    }
  }
}
