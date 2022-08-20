import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/provider/storge_provider.dart';
import 'package:myecommerce/views/routes.dart';
import 'package:provider/provider.dart';
import 'package:myecommerce/provider/auth_provaider.dart';
import 'package:myecommerce/views/admin/admin.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:myecommerce/views/routes.dart';

import 'package:myecommerce/views/screens/splash/splash_screen.dart';
import 'package:myecommerce/views/theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvaider>(
          create: (BuildContext context) {
            return  AuthProvaider();
          },
        ),
        ChangeNotifierProvider<CategoryFirestoreProvaider>(
          create: (BuildContext context) {
            return  CategoryFirestoreProvaider();
          },

        ),
        // ChangeNotifierProvider<StorgeProvider>(
        //   create: (BuildContext context) {
        //     return  StorgeProvider();
        //   },
        // ),
        ChangeNotifierProvider<ProductFirestoreProvaider>(
          create: (BuildContext context) {
            return  ProductFirestoreProvaider();
          },

        ),


      ],
      child: MyApp1(),
    );
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          392, 850),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: ( context, child){
        return MaterialApp(
          navigatorKey: AppRouter.navKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          home: SplashScreen(),
          // We use routeName so that we dont need to remember the name
          // initialRoute: SplashScreen.routeName,
          routes: routes,
        );
      }
    );

  }
}

