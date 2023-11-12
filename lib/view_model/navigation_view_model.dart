import 'package:expenses_managment_app_provider/view/screens/analyze_expenses/analyze_expenses.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/manage_expenses.dart';
import 'package:flutter/material.dart';

class NavigatorViewModel with ChangeNotifier {
  int currentIndex = 0;
  final List<Widget> pages = [
    const ManageExpenses(),
    const AnalyzeExpenses()
  ];
  Widget get currentPage => pages[currentIndex];

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}