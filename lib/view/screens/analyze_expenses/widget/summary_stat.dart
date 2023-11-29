import 'package:flutter/material.dart';
import 'custom_table.dart';

class SummaryStatistics extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String data1;
  final String data2;
  final String data3;
  final String data4;
  const SummaryStatistics(
      {super.key,
      required this.title1,
      required this.title2,
      required this.title3,
      required this.title4,
      required this.data1,
      required this.data2,
      required this.data3,
      required this.data4});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTable(
          title1: title1,
          title2: title2,
          data1: data1,
          data2: data2,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTable(title1: title3, title2: title4, data1: data3, data2: data4),
      ],
    );
  }
}
