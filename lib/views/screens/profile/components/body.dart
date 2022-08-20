import 'package:flutter/material.dart';
import 'package:myecommerce/views/admin/admin.dart';
import 'package:myecommerce/views/components/signout_dilog.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:myecommerce/views/profail/pages/profile_page.dart';

import '../../pageProfil/page_profil.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              AppRouter.NavigateToWidget(PageProfile())
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {
              AppRouter.NavigateToWidget(Admin());
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              DilogeSinout.show("Do you want to log out?");

            },
          ),
        ],
      ),
    );
  }
}
