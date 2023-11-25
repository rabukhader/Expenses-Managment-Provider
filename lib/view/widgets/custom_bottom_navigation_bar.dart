import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/navigation_view_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorViewModel>(
        builder:(context, navProvider, child) {
        return BottomNavigationBar(
        selectedItemColor: const Color(0xff177DFF),
        unselectedItemColor: Colors.grey,
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
