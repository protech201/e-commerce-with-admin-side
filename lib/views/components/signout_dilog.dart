import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myecommerce/provider/auth_provaider.dart';
import 'package:myecommerce/views/navigation/router.dart';

import '../constants.dart';

class CustomDialogSignOut extends StatelessWidget {

  String v;
  CustomDialogSignOut(this.v);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context,v),
    );
  }

  _buildChild(BuildContext context,String v) => Container(
    height: 300,
    decoration: BoxDecoration(
        color: kPrimaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('assets/images/sad.png', height: 120, width: 120,),
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
          ),
        ),
        SizedBox(height: 24,),
        // Text(v, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
        SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Text(v, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ),
        SizedBox(height: 24,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(onPressed: (){
              AppRouter.popraoter();
            }, child: Text('No'),textColor: Colors.white,),
            SizedBox(width: 8,),
            RaisedButton(onPressed: ()async{
              await Provider.of<AuthProvaider>(context,listen: false).signOut();
            }, child: Text('Yes'), color: Colors.white, textColor: Colors.redAccent,)
          ],
        )


      ],
    ),
  );
}

class DilogeSinout {
  static show(String v){
    return showDialog(context: AppRouter.navKey.currentContext!, builder: (context){
      return CustomDialogSignOut(v);
    });
  }
}


