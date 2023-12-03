import 'dart:async';
import 'package:expenses_managment_app_provider/model/data/expense_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/data/user_model.dart';

class HomeViewModel with ChangeNotifier {
  UserModel userModel = UserModel.instance;
  ExpenseModel expenseModel = ExpenseModel.instance;

  Future fetchExpenses() async {
    await expenseModel.fetchExpense();
  }

  Future<List<UserInfo?>> loadUserInfo() async {
    final data = await userModel.getUserInfo();
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
