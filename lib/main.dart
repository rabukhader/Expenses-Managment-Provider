import 'dart:async';

import 'package:camera/camera.dart';
import 'package:expenses_managment_app_provider/firebase_options.dart';
import 'package:expenses_managment_app_provider/theme/app_theme.dart';
import 'package:expenses_managment_app_provider/view/screens/choose_login_register/choose_login_register.dart';
import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:expenses_managment_app_provider/view_model/login_register_view_model.dart';
import 'package:expenses_managment_app_provider/view_model/navigation_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart' as UniLink;
import 'view_model/expense_view_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

late List<CameraDescription> cameras;

Future<void> checkDeepLink() async {
  final res = await UniLink.getInitialLink();
  if (res != null) {
    handleDeepLink(res);
  }

  UniLink.linkStream.listen((String? link) {
    if (link != null) {
      handleDeepLink(link);
    }
  });
}

void handleDeepLink(String link) {
  print('Received deep link: $link');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkDeepLink();
  FacebookAuth.instance.webAndDesktopInitialize(
    appId: '257911473923789',
    cookie: true,
    xfbml: true,
    version: 'v10.0',
  );
  cameras = await availableCameras();
  GeolocatorPlatform.instance;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ExpensesViewModel()),
    ChangeNotifierProvider(create: (_) => NavigatorViewModel()),
    ChangeNotifierProvider(create: (_) => LoginRegisterViewModel()),
  ], child: const ExpensesApp()));
}

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ChooseLoginRegister(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
      ]),
      debugShowCheckedModeBanner: false,
      // home: const ChooseLoginRegister(),
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
    );
  }
}
