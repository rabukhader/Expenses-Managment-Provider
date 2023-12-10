import 'package:expenses_managment_app_provider/model/data/user_model_supabase.dart';
import 'package:flutter/material.dart';
import '../model/services/analytics/all_analytics.dart';
import '../model/services/login_register_form/login_register_form.dart';

class LoginRegisterViewModel with ChangeNotifier {
  UserModelSupabase userModel = UserModelSupabase.instance;
  AllAnalytics analytics = AllAnalytics();
  LoginRegisterForm loginRegisterForm = LoginRegisterForm();

  Future<bool> loginEmailPassword(email, password) async {
    try {
      bool success = await userModel.loginEmailPassword(email, password);
      if (success) {
        await analytics.loginAnalytics('emailPasswordLogin');
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
        analytics.loginAnalytics('GoogleLogin');
        notifyListeners();
      }
      return success;
    } on Exception catch (error) {
      print(error);
      return false;
    }
  }
}
