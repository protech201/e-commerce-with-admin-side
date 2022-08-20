import 'package:flutter/material.dart';
import 'package:myecommerce/views/components/coustom_bottom_nav_bar.dart';
import 'package:myecommerce/views/enums.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(
            color: Colors.grey

        ),),),

      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
