import 'package:expenses_managment_app_provider/theme/theme_provider.dart';
import 'package:expenses_managment_app_provider/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userPhotoURL;
  const CustomDrawer(
      {super.key, required this.userName, required this.userPhotoURL});

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
              width: 280,
              itemTextPadding: const EdgeInsets.only(left: 10),
              textStyle: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onBackground,
              )),
          controller: SidebarXController(
            selectedIndex: 0,
          ),
          items: [
            SidebarXItem(
                label: userName,
                iconWidget: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 28,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(userPhotoURL != ''
                                        ? userPhotoURL
                                        : 'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA0L3BmLWljb240LWppcjIwNjItcG9yLWwtam9iNzg4LnBuZw.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ))),
                )),
            SidebarXItem(
                label: 'Theme',
                icon: Icons.sunny,
                onTap: () => Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme()),
            SidebarXItem(
              label: 'Log Out',
              icon: Icons.logout,
              onTap: () async {
                await Provider.of<HomeViewModel>(context, listen: false)
                    .signOut();
                Get.offAllNamed('/');
              },
            ),
          ],
        ),
      ],
    );
  }
}
