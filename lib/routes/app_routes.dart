import 'package:expenses_managment_app_provider/model/entities/expense_entity.dart';
import 'package:expenses_managment_app_provider/view/screens/analyze_expenses/analyze_expenses.dart';
import 'package:expenses_managment_app_provider/view/screens/choose_login_register/choose_login_register.dart';
import 'package:expenses_managment_app_provider/view/screens/error_screen/error_screen.dart';
import 'package:expenses_managment_app_provider/view/screens/expense_details/expense_details.dart';
import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:expenses_managment_app_provider/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:go_router/go_router.dart';
import '../view/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/', page: () => const ChooseLoginRegister()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/analyze', page: () => const AnalyzeExpenses()),
        GetPage(name: '/error', page: () => const ErrorScreen()),
        GetPage(
          name: '/details',
          page: () {
            late String id;
            Future<Expense?> fetchDataById() async {
              try {
                id = await Get.arguments as String;
                final response = await Supabase.instance.client
                    .from('expenses')
                    .select()
                    .eq('id', id)
                    .single();

                Map<String, dynamic> data = {
                  'name': response['name'],
                  'total': response['total'],
                  'dueDate': response['dueDate'],
                  'imageUrl': response['imageUrl'],
                  'address': response['address']
                };
                return Expense.fromMap(data);
              } catch (e) {
                print(e);
                return null;
              }
            }

            return FutureBuilder(
              future: fetchDataById(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const ErrorScreen();
                } else {
                  return ExpenseDetails(
                    id: id,
                    data: snapshot.data,
                  );
                }
              },
            );
          },
        ),
      ];
}
