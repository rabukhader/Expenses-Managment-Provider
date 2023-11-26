import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:expenses_managment_app_provider/theme/app_theme.dart';
import 'package:expenses_managment_app_provider/view/widgets/loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart' as unilink;
import 'package:http/http.dart' as http;

import 'package:expenses_managment_app_provider/firebase_options.dart';
import 'package:expenses_managment_app_provider/view/screens/choose_login_register/choose_login_register.dart';
import 'package:expenses_managment_app_provider/view/screens/expense_details/expense_details.dart';
import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:expenses_managment_app_provider/view_model/login_register_view_model.dart';
import 'package:expenses_managment_app_provider/view_model/navigation_view_model.dart';
import 'package:firebase_performance/firebase_performance.dart';

import 'view_model/expense_view_model.dart';
import 'view_model/theme_view_model.dart';

late List<CameraDescription> cameras;

Future<void> checkDeepLink() async {
  final res = await unilink.getInitialLink();
  if (res != null) {
    handleDeepLink(res);
  }

  unilink.linkStream.listen((String? link) {
    if (link != null) {
      handleDeepLink(link);
    }
  });
}

void handleDeepLink(String link) {
  print('Received deep link: $link');
}

Future<void> initDynamicLinks() async {
  final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
  handleLinkData(data);

  FirebaseDynamicLinks.instance.onLink.listen(
    (PendingDynamicLinkData? dynamicLink) async {
      handleLinkData(dynamicLink);
    },
  );
}

void handleLinkData(PendingDynamicLinkData? data) {
  if (data == null) {
    return;
  }

  final Uri deepLink = data.link;
  print(deepLink);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  GeolocatorPlatform.instance;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseDatabase database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(10000000);
  await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
  await checkDeepLink();
  await initDynamicLinks();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ExpensesViewModel()),
    ChangeNotifierProvider(create: (_) => NavigatorViewModel()),
    ChangeNotifierProvider(create: (_) => LoginRegisterViewModel()),
    ChangeNotifierProvider(create: (_) => ThemeViewModel()),
  ], child: const ExpensesApp()));
}

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  final performance = FirebasePerformance.instance;

  @override
  Widget build(BuildContext context) {
    final Trace buildTrace = performance.newTrace('build_method');
    final LoginRegisterViewModel loginRegisterViewModel =
        Provider.of<LoginRegisterViewModel>(context);
    buildTrace.start();

    Widget buildRouter(String initLocation) {
      return Consumer<ThemeViewModel>(
        builder: (context, theme, child) => MaterialApp.router(
          theme: theme.getCurrentTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          debugShowCheckedModeBanner: false,
          routerConfig: GoRouter(initialLocation: initLocation, routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const ChooseLoginRegister(),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/expenseDetails/:id',
              builder: (context, GoRouterState state) {
                String id = state.pathParameters['id'] ?? '';
                return FutureBuilder<Map<String, dynamic>>(
                  future: fetchDataById(id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    } else if (snapshot.hasError) {
                      return Scaffold(
                        body: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child:
                                Text('Error fetching data: ${snapshot.error}'),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      Expense sample = Expense.fromMap(snapshot.data!);
                      return ExpenseDetails(id: id, data: sample);
                    } else {
                      return const Center(child: Text('Error'));
                    }
                  },
                );
              },
            ),
          ]),
        ),
      );
    }

    Widget buildLoading() {
      return const MaterialApp(
        home: Loader(),
        debugShowCheckedModeBanner: false,
      );
    }

    Widget buildError(dynamic error) {
      return MaterialApp(home: Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $error'))));
    }

    return FutureBuilder(
      future: loginRegisterViewModel.getCurrentUser(),
      builder: (context, snapshot) {
        buildTrace.stop();

        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoading();
        } else if (snapshot.hasError) {
          return buildError(snapshot.error);
        } else if (snapshot.hasData && snapshot.data != null) {
          return buildRouter('/home');
        } else {
          return buildRouter('/');
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchDataById(String id) async {
    final Trace fetchDataTrace = performance.newTrace('fetchDataById');

    fetchDataTrace.start();

    final url =
        'https://providerrest-default-rtdb.firebaseio.com/expenses/$id.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        fetchDataTrace.stop();
        return json.decode(response.body);
      } else {
        fetchDataTrace.stop();
        throw Exception('Failed to load data');
      }
    } catch (error) {
      fetchDataTrace.stop();
      print('Error: $error');
      rethrow;
    }
  }
}
