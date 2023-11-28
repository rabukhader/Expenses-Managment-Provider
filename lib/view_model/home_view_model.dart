import 'package:flutter/material.dart';
import '../model/data/user_model.dart';

class HomeViewModel with ChangeNotifier {
  UserModel userModel = UserModel.instance;

  Future signOut() async {
    try {
      bool success = await userModel.signOut();
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
