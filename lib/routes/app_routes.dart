import 'package:expenses_managment_app_provider/view/screens/analyze_expenses/analyze_expenses.dart';
import 'package:expenses_managment_app_provider/view/screens/choose_login_register/choose_login_register.dart';
import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';
import '../view/screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static List<GoRoute> routes() => [
    GoRoute(path: '/splash', builder:  (context, state) => const SplashScreen()),
    GoRoute(path: '/', builder:  (context, state) => const ChooseLoginRegister()),
    GoRoute(path: '/home', builder:  (context, state) => const HomeScreen()),
    GoRoute(path: '/analyze', builder:  (context, state) => const AnalyzeExpenses()),
  ];
}
