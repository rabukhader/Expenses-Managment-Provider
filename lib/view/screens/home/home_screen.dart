import 'package:expenses_managment_app_provider/view/widgets/custom_bottom_navigation_bar.dart';
import 'package:expenses_managment_app_provider/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/navigation_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(),
          ),
          body: Selector<NavigationProvider, Widget>(
            selector: (_, navProvider) => navProvider.currentPage,
            builder: (context, page, child) {
              return page;
            },
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
          drawer: const CustomDrawer(),
        ),
      ),
    );
  }
}
