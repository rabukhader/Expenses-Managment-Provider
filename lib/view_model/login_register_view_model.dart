import 'package:expenses_managment_app_provider/model/data/user_model.dart';
import 'package:flutter/material.dart';

class LoginRegisterViewModel with ChangeNotifier {
  UserModel userModel = UserModel.instance;

  Future loginEmailPassword(email, password) async {
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

  Future signUpEmailPassword(email, password) async {
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
      print('error1111$error');
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
