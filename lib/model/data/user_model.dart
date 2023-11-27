import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel._();
    static final UserModel _instance = UserModel._();
    static UserModel get instance => _instance;

    User? user;
}
