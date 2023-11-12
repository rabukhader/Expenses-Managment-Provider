import 'package:expenses_managment_app_provider/firebase_options.dart';
import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:expenses_managment_app_provider/view_model/navigation_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view_model/expense_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ExpensesViewModel()),
    ChangeNotifierProvider(create: (_) => NavigatorViewModel()),
  ], child: const ExpensesApp()));
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
