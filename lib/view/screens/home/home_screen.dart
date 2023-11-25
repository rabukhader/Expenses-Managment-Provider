import 'package:expenses_managment_app_provider/view/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../view_model/navigation_view_model.dart';
import '../../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Expense Management App',
              style: GoogleFonts.openSans(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xff177DFF),
        ),
        body: Selector<NavigatorViewModel, Widget>(
          selector: (_, navProvider) => navProvider.currentPage,
          builder: (context, page, child) {
            return page;
          },
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
