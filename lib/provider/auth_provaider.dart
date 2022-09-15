import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecommerce/views/screens/nav_bar.dart';
import 'package:string_validator/string_validator.dart';

import 'package:myecommerce/data/authe_helper.dart';
import 'package:myecommerce/views/components/custom_dialog.dart';
import 'package:myecommerce/views/screens/complete_profile/complete_profile_screen.dart';
import 'package:myecommerce/views/screens/done/done_screen.dart';
import 'package:myecommerce/views/screens/sign_in/sign_in_screen.dart';

import '../data/storge_helper.dart';
import '../data/user_firestore_helper.dart';
import '../models/userModel.dart';
import '../views/navigation/router.dart';
import '../views/screens/home/home_screen.dart';


class AuthProvaider extends ChangeNotifier{
  AuthProvaider(){
    getData();
  }
  GlobalKey<FormState>? loginKey = GlobalKey();
  GlobalKey<FormState>? passKey = GlobalKey();

  GlobalKey<FormState> registerKey = GlobalKey();
  GlobalKey<FormState> completKey = GlobalKey();

  UserModel? userModel;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPassController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();


  nullvaliation(String? v){
    if(v == null || v.isEmpty){
      return"This field is required";
    }
  }
  passwrdvaliation(String v){
    if(v.isEmpty){
      return"Please Enter your password";
    }
    else if(v.length < 6){
      return"Password is too short";
    }
  }
  conformPassvaliation(String v){
    if(v.isEmpty){
      return"Please Enter your password";
    }
    else if(v.length < 6){
      return"Password is too short";
    }else if(v != passwordController.text){
      return"Passwords don't match";
    }
  }
  emailvaliation(String v){
    if(v.isEmpty){
      return"Please Enter your email";
    }
    else if(!isEmail(v)){
      return"Please Enter Valid Email";
    }
  }
  signIn()async{
    if(loginKey!.currentState!.validate()){
      UserCredential? userCredential =    await AuthHelper.authHelper.signIn(emailController.text, passwordController.text);
      getData();
      if(userCredential != null){
      // loginKey = null;
      AppRouter.NavigateWithReplacemtnToWidget(NavBar());
      passwordController.clear();
      emailController.clear();
    }
    }

  }


  register()async{
    if(registerKey.currentState!.validate()){
    UserCredential? userCredential = await AuthHelper.authHelper.signUp(emailController.text, passwordController.text);
    // userModel = UserModel(email: emailController.text, userName: userNameController.text, city: cityController.text, phone: phoneController.text,id:userCredential!.user!.uid );
    // await UserFirestoreHelper.firestoreHelper.addUserToFirestore(userModel!);
    if(userCredential != null){
      AppRouter.NavigateWithReplacemtnToWidget(CompleteProfileScreen());
      passwordController.clear();
      // emailController.clear();
      conformPassController.clear();

    }
    }
  }

  savingData()async{
     userModel = UserModel(
        email: emailController.text,
        userName: userNameController.text,
        city: cityController.text,
        phone: phoneController.text,
      id: FirebaseAuth.instance.currentUser!.uid,
    );
     emailController.text = userModel!.email;
     userNameController.text = userModel!.userName;
     phoneController.text = userModel!.phone;
     cityController.text = userModel!.city;

    await UserFirestoreHelper.firestoreHelper.addUserToFirestore(userModel!);
  }




  checUser() async {
    User? user = await AuthHelper.authHelper.checUser();
     if(user == null){
       AppRouter.NavigateWithReplacemtnToWidget(SignInScreen());
     }else{
       // userModel = await UserFirestoreHelper.firestoreHelper.getUserFromFirestore(user.uid);
       AppRouter.NavigateWithReplacemtnToWidget(NavBar());
     }

  }
  signOut()async{
    // loginKey = GlobalKey();
     await AuthHelper.authHelper.signOut();
     Navigator.of(AppRouter.navKey.currentContext!).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInScreen()), (route) => false);

  }

  forgetPassurd()async{
    if(passKey!.currentState!.validate()){
     await AuthHelper.authHelper.forgetPassurd(emailController.text);
     Diloge.show('Check your email');
      emailController.clear();

    }

  }
  getData()async{
    if(FirebaseAuth.instance.currentUser?.uid != null){
      userModel = await UserFirestoreHelper.firestoreHelper.getUserFromFirestore(FirebaseAuth.instance.currentUser!.uid);
      emailController.text = userModel!.email;
      userNameController.text = userModel!.userName;
      phoneController.text = userModel!.phone;
      cityController.text = userModel!.city;
      passwordController.clear();
    }
  }

  File? selectedImage;


 Future<String> uploadImage(File file)async{
   log('url');

   String url = await StorgeHelper.storgeHelper.uplodImage(file);
    log(url);
    return url;
  }

  selecteImageFun()async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage= File(xfile!.path);
    notifyListeners();
  }

  upDateImage()async{
    userModel!.urlImage = await uploadImage(selectedImage!);
    await UserFirestoreHelper.firestoreHelper.upDateImage(userModel!);
    notifyListeners();
  }

  upDateUser()async{
   userModel?.email = emailController.text;
   userModel?.phone = phoneController.text;
   userModel?.userName = userNameController.text;
   userModel?.city = cityController.text;
   await UserFirestoreHelper.firestoreHelper.upDateUser(userModel!);
   notifyListeners();
  }





}
//SystemChannels.platform.invokeMethod('SystemNavigator.pop');