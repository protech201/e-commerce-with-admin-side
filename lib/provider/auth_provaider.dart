import 'dart:developer';
import 'dart:io';

import 'package:dialog_loader/dialog_loader.dart';
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

  DialogLoader dialogLoader = DialogLoader(context: AppRouter.navKey.currentContext!);

  _dialogLoader() async {

    dialogLoader.show(
      theme: LoaderTheme.dialogCircle,
      title: Text("Loading"),
      leftIcon: SizedBox(
        child: CircularProgressIndicator(),
        height: 25.0,
        width: 25.0,
      ),
    );
  }


  signIn()async{
    if(loginKey!.currentState!.validate()){
      _dialogLoader();

      UserCredential? userCredential =    await AuthHelper.authHelper.signIn(emailController.text, passwordController.text);
      getData();
      if(userCredential != null){
      // loginKey = null;
        dialogLoader.close();

        AppRouter.NavigateWithReplacemtnToWidget(NavBar());
      passwordController.clear();
      emailController.clear();
    }
    }

  }


  register()async{
    if(registerKey.currentState!.validate()){
      _dialogLoader();

      UserCredential? userCredential = await AuthHelper.authHelper.signUp(emailController.text, passwordController.text);
    // userModel = UserModel(email: emailController.text, userName: userNameController.text, city: cityController.text, phone: phoneController.text,id:userCredential!.user!.uid );
    // await UserFirestoreHelper.firestoreHelper.addUserToFirestore(userModel!);
    if(userCredential != null){
      dialogLoader.close();

      AppRouter.NavigateWithReplacemtnToWidget(CompleteProfileScreen());
      passwordController.clear();
      // emailController.clear();
      conformPassController.clear();

    }
    }
  }

  savingData()async{
    if(completKey.currentState!.validate()){
      _dialogLoader();

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
      dialogLoader.close();

    }

  }




  checUser() async {
    _dialogLoader();

    User? user = await AuthHelper.authHelper.checUser();
     if(user == null){
       dialogLoader.close();

       AppRouter.NavigateWithReplacemtnToWidget(SignInScreen());
     }else{
       // userModel = await UserFirestoreHelper.firestoreHelper.getUserFromFirestore(user.uid);
       dialogLoader.close();

       AppRouter.NavigateWithReplacemtnToWidget(NavBar());
     }


  }
  signOut()async{
    // loginKey = GlobalKey();
     await AuthHelper.authHelper.signOut();
     Navigator.of(AppRouter.navKey.currentContext!).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInScreen()), (route) => false);
     controller.index = 0;

  }

  forgetPassurd()async{
    if(passKey!.currentState!.validate()){
      _dialogLoader();

      await AuthHelper.authHelper.forgetPassurd(emailController.text);
      dialogLoader.close();


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

  upDateImage()async {
    _dialogLoader();

    userModel!.urlImage = await uploadImage(selectedImage!);

    await UserFirestoreHelper.firestoreHelper.upDateImage(userModel!);
    notifyListeners();
    dialogLoader.close();

  }

  upDateUser()async{
   _dialogLoader();

    userModel?.email = emailController.text;
   userModel?.phone = phoneController.text;
   userModel?.userName = userNameController.text;
   userModel?.city = cityController.text;
   await UserFirestoreHelper.firestoreHelper.upDateUser(userModel!);
    dialogLoader.close();

    notifyListeners();
  }





}
//SystemChannels.platform.invokeMethod('SystemNavigator.pop');