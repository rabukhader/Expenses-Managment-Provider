import 'package:expenses_managment_app_provider/model/data/user_model.dart';
import 'package:flutter/material.dart';

class LoginRegisterViewModel with ChangeNotifier {
  UserModel userModel = UserModel.instance;

  Future<bool> loginEmailPassword(email, password) async {
    try {
      bool success = await userModel.loginEmailPassword(email, password);
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUpEmailPassword(email, password) async {
    try {
      bool success = await userModel.signUpEmailPassword(email, password);
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      bool success = await userModel.signInWithGoogle();
      if (success) {
        notifyListeners();
      }
      return success;
    } on Exception catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      bool success = await userModel.signInWithFacebook();
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }

}
