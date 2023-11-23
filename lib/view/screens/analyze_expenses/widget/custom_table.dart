import 'package:flutter/material.dart';

import 'cell.dart';

class CustomTable extends StatelessWidget {
  final String title1;
  final String title2;
  final String data1;
  final String data2;
  const CustomTable({super.key, required this.title1, required this.title2, required this.data1, required this.data2});
  @override
  Widget build(BuildContext context) {

    return Table(
          border: TableBorder.all(),
          children: [
            TableRow(children: [

              Cell(title: title1,data: data1),
              Cell(title: title2,data: data2),
            ])
          ],
        );
  }
}