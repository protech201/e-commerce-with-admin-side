import 'package:flutter/material.dart';
import 'package:myecommerce/views/components/custom_dialog.dart';
import 'package:myecommerce/views/screens/nav_bar.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In",style: TextStyle(
          color: Colors.grey
        ),),

      ),
      body:  WillPopScope(
          onWillPop: (){
            if(Navigator.canPop(context)){
              return Future.value(true);
            }else{
              // SystemNavigator.pop();
              Diloge.show("هل تريد الخروج");
              return Future.value(false);
            }
          },child: Body()),
    );
  }
}
