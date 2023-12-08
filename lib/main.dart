import 'package:expenses_managment_app_provider/firebase_options.dart';
import 'package:expenses_managment_app_provider/routes/app_routes.dart';
import 'package:expenses_managment_app_provider/theme/app_theme.dart';
import 'package:expenses_managment_app_provider/theme/theme_provider.dart';
import 'package:expenses_managment_app_provider/utils/supabase_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
      url: SupabaseConfig.projectURL, anonKey: SupabaseConfig.apiKey);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ], child: const ExpensesApp()));
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, theme, child) {
      return GetMaterialApp(
        initialRoute: '/splash',
        debugShowCheckedModeBanner: false,
        theme: theme.getCurrentTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        getPages: AppRoutes.routes(),
      );
    });
  }
}
