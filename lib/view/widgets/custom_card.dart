import 'package:expenses_managment_app_provider/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/entities/expense_entity.dart';

class CustomCard extends StatelessWidget {
  final onTap;
  final String id;
  final Expense data;
  final List<CustomButton> buttons;
  const CustomCard(
      {super.key,
      required this.data,
      required this.buttons,
      this.onTap,
      required this.id});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.onSecondary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap != null ? onTap! : () {},
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [color, Theme.of(context).primaryColor, color]),
              color: color,
              borderRadius: BorderRadius.circular(15)),
          width: 320,
          height: 220,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.name,
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 14),
                    ),
                    Row(
                      children: [
                        Text(
                          data.total.toString(),
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                        SvgPicture.asset(
                          'assets/dolar.svg',
                          width: 32,
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      buttons.map((button) => button.build(context)).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
