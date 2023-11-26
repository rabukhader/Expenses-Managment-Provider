import 'package:expenses_managment_app_provider/routes/app_routes.dart';
import 'package:expenses_managment_app_provider/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:expenses_managment_app_provider/firebase_options.dart';
import 'package:expenses_managment_app_provider/view_model/login_register_view_model.dart';
import 'view_model/theme_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginRegisterViewModel()),
    ChangeNotifierProvider(create: (_) => ThemeViewModel()),
  ], child: const ExpensesApp()));
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, theme, child) => MaterialApp.router(
        theme: theme.getCurrentTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        routerConfig:
            GoRouter(initialLocation: '/splash', routes: AppRoutes.routes()),
      ),
    );
  }
}
