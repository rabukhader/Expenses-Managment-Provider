// import 'package:expenses_managment_app_provider/model/services/analytics/analytics.dart';
import 'package:expenses_managment_app_provider/model/services/login_register_form/login_register_form.dart';
import 'package:expenses_managment_app_provider/view/widgets/loader.dart';
import 'package:expenses_managment_app_provider/view_model/login_register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../login_register_screen/login_register_screen.dart';

class ChooseLoginRegister extends StatelessWidget {
  const ChooseLoginRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginRegisterViewModel(),
        child: const ChooseLoginRegisterView());
  }
}

class ChooseLoginRegisterView extends StatefulWidget {
  const ChooseLoginRegisterView({super.key});

  @override
  State<ChooseLoginRegisterView> createState() =>
      _ChooseLoginRegisterViewState();
}

class _ChooseLoginRegisterViewState extends State<ChooseLoginRegisterView> {
  LoginRegisterForm loginRegisterForm = LoginRegisterForm();
  // Analytics analytics = Analytics();
  @override
  Widget build(BuildContext context) {
    final lgProvider =
        Provider.of<LoginRegisterViewModel>(context, listen: false);
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
                              color: Theme.of(context).primaryColor,
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
                bottom: -45,
                top: 350,
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).hintColor,
                                  spreadRadius: 3,
                                  blurRadius: 50)
                            ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                            color: Theme.of(context).colorScheme.onSecondary),
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
                                                color:
                                                    Theme.of(context).hintColor,
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
                                      onPressed: () {
                                        // analytics.sendLogEvent(
                                        //     'go_to_sign_in');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginRegisterScreen(
                                                        processName: 'Sign In',
                                                        loginRegisterForm:
                                                            loginRegisterForm,
                                                        onSubmit: lgProvider
                                                            .loginEmailPassword)));
                                      },
                                      style: ButtonStyle(
                                          shadowColor: MaterialStatePropertyAll(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary)),
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
                                              offset: const Offset(0, 3),
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
                                      onPressed: () async{
                                        // analytics.sendLogEvent(
                                        //     'go_to_sign_up');
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginRegisterScreen(
                                                        processName: 'Sign Up',
                                                        onSubmit: lgProvider
                                                            .signUpEmailPassword,
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
                                                      .onSecondary)),
                                      child: Container(
                                        width: 90,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          color: Theme.of(context).primaryColor,
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
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary)),
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const AlertDialog(
                                              content: SizedBox(
                                                  width: 30,
                                                  height: 150,
                                                  child: Loader()),
                                            ),
                                          );
                                          // analytics.sendLoginEvent('Google_login');
                                          // try {
                                          //   var result = await Provider.of<
                                          //       LoginRegisterViewModel>(
                                          //     context,
                                          //     listen: false,
                                          //   ).signInWithGoogle();
                                          //   Navigator.pop(context);

                                          //   if (result) {
                                          //     GoRouter.of(context).go('/home',
                                          //         extra: (state) =>
                                          //             state.isRoot);
                                          //   }
                                          // } catch (error) {
                                          //   Navigator.pop(context);
                                          // }
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
                                        onPressed: (){} /* async {
                                          var result = await Provider.of<
                                                      LoginRegisterViewModel>(
                                                  context,
                                                  listen: false)
                                              .signInWithFacebook();
                                          if (result) {
                                            GoRouter.of(context).go('/home',
                                                extra: (state) => state.isRoot);
                                          }
                                        } */,
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary)),
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
