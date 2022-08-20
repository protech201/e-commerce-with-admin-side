

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../navigation/router.dart';
import '../home/home_screen.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);
  initFun()async{
    // Provider.of<FirestoreProvider>(AppRouter.navKey.currentContext!).getAllCourses();
    await Future.delayed(Duration(seconds: 2));
    AppRouter.NavigateWithReplacemtnToWidget(HomeScreen());

  }
  @override
  Widget build(BuildContext context) {
    initFun();
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/Animation/80036-done.json'),

      ),
    );
  }
}
