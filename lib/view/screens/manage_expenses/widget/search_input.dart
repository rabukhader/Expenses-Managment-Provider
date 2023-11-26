import 'dart:async';

// import 'package:expenses_managment_app_provider/view_model/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

class SearchInput extends StatefulWidget {
  final StreamController<String> textStream;
  final Function(String) onSearch;
  const SearchInput(
      {super.key, required this.textStream, required this.onSearch});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final textController = TextEditingController();
  // late ExpensesViewModel expensesViewModel;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   expensesViewModel = Provider.of<ExpensesViewModel>(context, listen: false);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   textController.addListener(() {
  //     expensesViewModel.textStream.add(textController.text);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      child: TextField(
        controller: textController,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onBackground),
        onChanged: (text) {
          //to parent widget
          widget.onSearch(text);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onBackground),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).hintColor,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }
}
