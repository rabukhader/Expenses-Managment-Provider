import 'package:expenses_managment_app_provider/model/services/login_register_form/login_register_form.dart';
import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:expenses_managment_app_provider/view_model/login_register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widget/bazier_container.dart';

class LoginRegisterScreen extends StatefulWidget {
  final String processName;
  final LoginRegisterForm loginRegisterForm;
  const LoginRegisterScreen(
      {super.key, required this.processName, required this.loginRegisterForm});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          widget.loginRegisterForm.clear();
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/user.png',
                      scale: 4,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        controller: widget.loginRegisterForm.emailController,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff009688), width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff009688), width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            labelText: 'Email',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.4)),
                            hintText: 'Your Email Address',
                            floatingLabelStyle:
                                const TextStyle(color: Color(0xffB1AAE8)),
                            labelStyle: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff009688),
                                fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: widget.loginRegisterForm.passwordController,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff009688), width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff009688), width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            labelText: 'Password',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.4)),
                            hintText: 'Enter Your password',
                            floatingLabelStyle:
                                const TextStyle(color: Color(0xffB1AAE8)),
                            suffixIcon: IconButton(
                              splashRadius: 20,
                              splashColor:
                                  const Color(0xff009688).withOpacity(0.2),
                              onPressed: () {},
                              icon: const Icon(Icons.visibility_off),
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff009688),
                                fontWeight: FontWeight.w500)),
                        // obscureText: !isPasswordVisible,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () async {
                    final pr = Provider.of<LoginRegisterViewModel>(context,
                        listen: false);
                    widget.processName == 'Sign In'
                        ? await pr.loginEmailPassword(
                            widget.loginRegisterForm.emailController.text,
                            widget.loginRegisterForm.passwordController.text)
                        : await pr.signUpEmailPassword(
                            widget.loginRegisterForm.emailController.text,
                            widget.loginRegisterForm.passwordController.text);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  },
                  style: ButtonStyle(
                      shadowColor: const MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.background)),
                  child: Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.onBackground),
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(widget.processName,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground))),
                  )),
            ],
          )
        ],
      )),
    );
  }
}
