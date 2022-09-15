
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:myecommerce/views/components/custom_dialog.dart';
import 'package:myecommerce/views/navigation/router.dart';

import '../views/screens/sign_in/sign_in_screen.dart';

class AuthHelper {

  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(String email, String password) async {
    try {

      final credential = await firebaseAuth.createUserWithEmailAndPassword(

        email: email,
        password: password,
      );
      log("message1");

      return credential;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Diloge.show("The account already exists for that email.");
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }

  Future<UserCredential?>  signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Diloge.show('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Diloge.show('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }

  }

  Future<User?> checUser() async {
    User? user = await  firebaseAuth.currentUser;

    return user;
  }

  signOut()async{
    await firebaseAuth.signOut();

  }

  forgetPassurd(String email)async{
    try {
      await  firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception catch (e) {
      Diloge.show('No user found for that email.');

      // TODO
    }
  }

  verifyEmail(){
    User? user = firebaseAuth.currentUser;
    user!.sendEmailVerification();
  }

}