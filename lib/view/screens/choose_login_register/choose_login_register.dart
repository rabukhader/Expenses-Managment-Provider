import 'package:expenses_managment_app_provider/model/services/login_register_form/login_register_form.dart';
import 'package:expenses_managment_app_provider/view_model/login_register_view_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../login_register_screen/login_register_screen.dart';

class ChooseLoginRegister extends StatefulWidget {
  const ChooseLoginRegister({super.key});

  @override
  State<ChooseLoginRegister> createState() => _ChooseLoginRegisterState();
}

class _ChooseLoginRegisterState extends State<ChooseLoginRegister> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'button_click',
      parameters: <String, dynamic>{
        'page': 'home',
        'button_id': 'example_button',
      },
    );
    await analytics.logLogin(loginMethod: 'Email Password');
  }

  LoginRegisterForm loginRegisterForm = LoginRegisterForm();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              children: [
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: width,
                          height: height / 2,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onBackground,
                              image: const DecorationImage(
                                  scale: 2.5,
                                  image: AssetImage(
                                      'assets/fund-agreement-for-startup.png'))),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                top: 350,
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                            color: Theme.of(context).colorScheme.background),
                        width: width,
                        height: height / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 40, right: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Welcome to \n',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                fontSize: 40)),
                                        TextSpan(
                                            text: 'EMA !\n',
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xff177DFF),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40)),
                                        TextSpan(
                                            text: 'Expenses Managment App',
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        await sendAnalyticsEvent();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginRegisterScreen(
                                                        processName: 'Sign In',
                                                        loginRegisterForm:
                                                            loginRegisterForm)));
                                      },
                                      style: ButtonStyle(
                                          shadowColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.black),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .background)),
                                      child: Container(
                                        width: 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                            child: Text("Signin",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground))),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginRegisterScreen(
                                                        processName: 'Sign Up',
                                                        loginRegisterForm:
                                                            loginRegisterForm)));
                                      },
                                      style: ButtonStyle(
                                          shadowColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.black),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .background)),
                                      child: Container(
                                        width: 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          color: const Color(0xff177DFF),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                            child: Text("Signup",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground))),
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Divider(
                                    indent: 0,
                                    endIndent: 10,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  )),
                                  Center(
                                    child: Text(
                                      "Or",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                    ),
                                  ),
                                  Expanded(
                                      child: Divider(
                                    indent: 10,
                                    endIndent: 0,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .background)),
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialog(
                                            content: SizedBox(
                                                width: 30,
                                                height: 150,
                                                child:
                                                    CircularProgressIndicator(
                                                  value: null,
                                                )),
                                          ),
                                        );

                                        try {
                                          var result = await Provider.of<
                                              LoginRegisterViewModel>(
                                            context,
                                            listen: false,
                                          ).signInWithGoogle();

                                          Navigator.pop(context);

                                          if (result) {
                                            GoRouter.of(context).go('/home',
                                                extra: (state) => state.isRoot);
                                          }
                                        } catch (error) {
                                          // Handle errors if the sign-in fails
                                          // Dismiss the loading indicator
                                          Navigator.pop(context);

                                          // Show an error message or handle the error as needed
                                          print(
                                              "Error signing in with Google: $error");
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            "Google",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Image.asset(
                                            'assets/google.png',
                                            width: 50,
                                          ),
                                        ],
                                      )),
                                  ElevatedButton(
                                      onPressed: () async {
                                        var result = await Provider.of<
                                                    LoginRegisterViewModel>(
                                                context,
                                                listen: false)
                                            .signInWithFacebook();
                                        if (result) {
                                          GoRouter.of(context).go('/home',
                                              extra: (state) => state.isRoot);
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .background)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Facebook",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Image.asset(
                                            'assets/facebook.png',
                                            width: 50,
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
