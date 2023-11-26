import 'package:expenses_managment_app_provider/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../view_model/login_register_view_model.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SidebarX(
          theme: SidebarXTheme(
              width: 80,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor,
                    blurRadius: 100,
                    spreadRadius: 0.1)
              ], color: Theme.of(context).colorScheme.background)),
          extendedTheme: SidebarXTheme(
              selectedTextStyle: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              selectedItemTextPadding: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(10),
              itemMargin: const EdgeInsets.all(10),
              width: 150,
              itemTextPadding: const EdgeInsets.only(left: 10),
              textStyle: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onBackground,
              )),
          controller: SidebarXController(
            selectedIndex: 0,
          ),
          items: [
            SidebarXItem(
                label: 'User',
                
                iconWidget: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 28,
                          child: Container(
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/user.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ))),
                )),
            SidebarXItem(
                label: 'Theme',
                icon: Icons.sunny,
                onTap: () => Provider.of<ThemeViewModel>(context, listen: false)
                    .toggleTheme()),
            SidebarXItem(
              label: 'Log Out',
              icon: Icons.logout,
              onTap: () async {
                await Provider.of<LoginRegisterViewModel>(context,
                        listen: false)
                    .signOut();
                GoRouter.of(context).go('/');
              },
            ),
          ],
        ),
      ],
    );
  }
}
