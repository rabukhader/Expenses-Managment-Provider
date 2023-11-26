import 'package:expenses_managment_app_provider/view/screens/analyze_expenses/analyze_expenses.dart';
import 'package:expenses_managment_app_provider/view/screens/choose_login_register/choose_login_register.dart';
import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';

import '../view/screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static List<GoRoute> routes() => [
    GoRoute(path: '/splash', builder:  (context, state) => const SplashScreen()),
    GoRoute(path: '/home', builder:  (context, state) => const HomeScreen()),
    GoRoute(path: '/', builder:  (context, state) => const ChooseLoginRegister()),
    GoRoute(path: '/analyze', builder:  (context, state) => const AnalyzeExpenses()),
    // GoRoute(
    //           path: '/expenseDetails/:id',
    //           builder: (context, GoRouterState state) {
    //             String id = state.pathParameters['id'] ?? '';
    //             return FutureBuilder<Map<String, dynamic>>(
    //               future: fetchDataById(id),
    //               builder: (context, snapshot) {
    //                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                   return const Loader();
    //                 } else if (snapshot.hasError) {
    //                   return Scaffold(
    //                     body: Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Center(
    //                         child:
    //                             Text('Error fetching data: ${snapshot.error}'),
    //                       ),
    //                     ),
    //                   );
    //                 } else if (snapshot.hasData) {
    //                   Expense sample = Expense.fromMap(snapshot.data!);
    //                   return ExpenseDetails(id: id, data: sample);
    //                 } else {
    //                   return const Center(child: Text('Error'));
    //                 }
    //               },
    //             );
    //           },
    //         ),
  ];
}
