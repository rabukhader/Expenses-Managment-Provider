import 'dart:convert';
import 'package:expenses_managment_app_provider/model/data/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRegisterViewModel with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  UserModel userModel = UserModel.instance;

  Future loginEmailPassword(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      User? currentUser = auth.currentUser;
      userModel.user = currentUser;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future signUpEmailPassword(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? currentUser = auth.currentUser;
      userModel.user = currentUser;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final authAccount = await account.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: authAccount.idToken, accessToken: authAccount.accessToken);
        await auth.signInWithCredential(credential);
        User? currentUser = auth.currentUser;
        userModel.user = currentUser;
        notifyListeners();
        return true;
      }
      return false;
    } on Exception catch (error) {
      print('error1111$error');
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      print(loginResult);
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await auth.signInWithCredential(facebookAuthCredential);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
      print("User signed out");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<Map<String, dynamic>> fetchDataById(String id) async {
    final url =
        'https://providerrest-default-rtdb.firebaseio.com/expenses/$id.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
