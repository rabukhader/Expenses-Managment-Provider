import 'package:expenses_managment_app_provider/view/screens/choose_login_register/choose_login_register.dart';
import 'package:expenses_managment_app_provider/view/widgets/custom_bottom_navigation_bar.dart';
import 'package:expenses_managment_app_provider/view_model/login_register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../view_model/navigation_view_model.dart';

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
        appBar: AppBar(
          title: Text('Expense Management App', style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.grey[900],
          actions: [
            IconButton(onPressed: ()async {
              await Provider.of<LoginRegisterViewModel>(context, listen: false).signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> ChooseLoginRegister()), (route) => false);
            }, icon: const Icon(Icons.logout))
          ],
        ),
        body: Selector<NavigatorViewModel, Widget>(
          selector: (_,navProvider) => navProvider.currentPage,
          builder:(context, page, child) {
          return page;
        } ,), 
        
        bottomNavigationBar: const CustomBottomNavigationBar()
      ),
    );
  }
}
