import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/splash_view_model.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => SplashViewModel(),
      child: const SplashView());
  }
}

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    var mainGradient = LinearGradient(
      colors: [Theme.of(context).primaryColor, Theme.of(context).hintColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient),
        alignment: Alignment.center,
        child: Image.asset(
          "assets/user.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final splashViewModel = Provider.of<SplashViewModel>(context, listen: false);

    Future.delayed(const Duration(milliseconds: 200), () {
      splashViewModel.init(context);
    });
  }
}
