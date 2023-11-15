import 'package:flutter/material.dart';

class LoginRegisterForm{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  clear(){
    emailController.clear();
    passwordController.clear();
  }

}