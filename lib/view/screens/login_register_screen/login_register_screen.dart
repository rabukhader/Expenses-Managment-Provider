import 'package:expenses_managment_app_provider/model/services/login_register_form/login_register_form.dart';
import 'package:expenses_managment_app_provider/view/widgets/custom_text_field.dart';
import 'package:expenses_managment_app_provider/view_model/login_register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/dialog.dart';
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
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
                onPressed: () {
                  widget.loginRegisterForm.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/user.png',
                      scale: 2,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: widget.loginRegisterForm.formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                            controller:
                                widget.loginRegisterForm.emailController,
                            label: 'Email'),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller:
                                widget.loginRegisterForm.passwordController,
                            label: 'Password')
                      ]),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () async {
                    final bool result;
                    final pr = Provider.of<LoginRegisterViewModel>(context,
                        listen: false);
                    widget.processName == 'Sign In'
                        ? result = await pr.loginEmailPassword(
                            widget.loginRegisterForm.emailController.text,
                            widget.loginRegisterForm.passwordController.text)
                        : result = await pr.signUpEmailPassword(
                            widget.loginRegisterForm.emailController.text,
                            widget.loginRegisterForm.passwordController.text);
                    if (result) {
                      GoRouter.of(context).go('/home');
                    } else {
                      errorDialog(context, 'Invalid Credentials');
                    }
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
                      color: Theme.of(context).hintColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(widget.processName,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.background))),
                  )),
            ],
          )
        ],
      )),
    );
  }
}
