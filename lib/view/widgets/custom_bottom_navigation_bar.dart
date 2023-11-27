import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../view_model/navigation_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
        builder:(context, navProvider, child) {
        return BottomNavigationBar(
          elevation: 25,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        selectedItemColor: Theme.of(context).hintColor,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        selectedLabelStyle: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.onBackground
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Manage Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Analyze Expenses',
          ),
        ],
        currentIndex: navProvider.currentIndex,
        onTap: (index){
          navProvider.changePage(index);
        },
    );
      } );
  }
}
