import 'package:flutter/material.dart';

class LoginRegisterForm {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  clear() {
    emailController.clear();
    passwordController.clear();
  }
}
