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
    
    return [currentUser?.email, ''];
  }

  void clearUserInfo() {
    user = null;
  }
}
