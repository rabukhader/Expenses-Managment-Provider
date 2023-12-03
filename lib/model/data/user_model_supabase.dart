import 'package:expenses_managment_app_provider/utils/supabase_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModelSupabase {
  final supabaseAuth = Supabase.instance.client.auth;
  User? user;
  UserModelSupabase._();
  static final UserModelSupabase _instance = UserModelSupabase._();
  static UserModelSupabase get instance => _instance;

  Future loginEmailPassword(email, password) async {
    try {
      await supabaseAuth.signInWithPassword(email: email, password: password);
      User? currentUser = supabaseAuth.currentUser;
      user = currentUser;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future signUpEmailPassword(email, password) async {
    try {
      await supabaseAuth.signUp(email: email, password: password);
      User? currentUser = supabaseAuth.currentUser;
      user = currentUser;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: SupabaseConfig.iosClientId,
        serverClientId: SupabaseConfig.webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }
      final result = await supabaseAuth.signInWithIdToken(
        provider: Provider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      user = result.user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await supabaseAuth.signOut();
      clearUserInfo();
      return true;
    } catch (e) {
      print("Error signing out: $e");
      return false;
    }
  }

  getUserInfo() {
    User? currentUser = supabaseAuth.currentUser;
    if (currentUser?.appMetadata['provider'] == 'google'){
      return [currentUser?.userMetadata!['full_name'], currentUser?.userMetadata!['picture']];
    }
    return [currentUser?.email, ''];
  }

  void clearUserInfo() {
    user = null;
  }
}
