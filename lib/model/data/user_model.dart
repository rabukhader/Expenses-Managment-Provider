import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  final auth = FirebaseAuth.instance;
  User? user;
  UserModel._();
  static final UserModel _instance = UserModel._();
  static UserModel get instance => _instance;

  Future loginEmailPassword(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      User? currentUser = auth.currentUser;
      user = currentUser;
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
      user = currentUser;
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
        user = currentUser;
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
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await auth.signInWithCredential(facebookAuthCredential);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await auth.signOut();
      clearUserInfo(); // Clear user information
      return true;
    } catch (e) {
      print("Error signing out: $e");
      return false;
    }
  }

  void clearUserInfo() {
    user = null;
  }
}
