import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myecommerce/models/userModel.dart';
import 'package:myecommerce/provider/auth_provaider.dart';
import 'package:myecommerce/views/profail/pages/edit_description.dart';
import 'package:myecommerce/views/profail/pages/edit_email.dart';
import 'package:myecommerce/views/profail/pages/edit_image.dart';
import 'package:myecommerce/views/profail/pages/edit_name.dart';
import 'package:myecommerce/views/profail/pages/edit_phone.dart';
import 'package:provider/provider.dart';
import '../widgets/display_image_widget.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
          body: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 10,
              ),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(64, 105, 225, 1),
                        ),
                      ))),
              InkWell(
                  onTap: () {
                    navigateSecondPage(EditImagePage());
                  },
                  child: DisplayImage(
                    imagePath: Provider.of<AuthProvaider>(context,listen: false).userModel!.urlImage!,
                    onPressed: () {},
                  )),
              buildUserInfoDisplay(Provider.of<AuthProvaider>(context,listen: false).userModel!.userName, 'Name', EditNameFormPage()),
              buildUserInfoDisplay(Provider.of<AuthProvaider>(context,listen: false).userModel!.phone, 'Phone', EditPhoneFormPage()),
              buildUserInfoDisplay(Provider.of<AuthProvaider>(context,listen: false).userModel!.email, 'Email', EditEmailFormPage()),
              Expanded(
                child: buildAbout(Provider.of<AuthProvaider>(context,listen: false).userModel!),
                flex: 4,
              )

            ],
          ),
        );


  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(UserModel user) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          // navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.id!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
