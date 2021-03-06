import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:super_store/model/cart_model.dart';

import 'package:super_store/view/cart/cart_home.dart';
import 'package:super_store/view/home/home.dart';

import 'package:super_store/view/login/login_home.dart';
import 'package:super_store/view/register/register_home.dart';

import 'config/constraints.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: CartItems())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
        initialRoute: '/',
        routes: {
          '/Home': (context) => Home(),
          '/LogIn': (context) => LoginHome(),
          '/SignUp': (context) => RegisterHome(),
          '/Cart': (context) => CartHome(),
        },
      ),
    ),
  );
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    Future.delayed(Duration(seconds: 3), () {
      Get.to(() => LoginHome());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SUPER',
              style: TextStyle(
                color: Constraints.APP_BAR_HOME_TEXT1_COLOR,
                fontSize: 30.0,
              ),
            ),
            Text(
              'STORE',
              style: TextStyle(
                color: Constraints.APP_BAR_HOME_TEXT2_COLOR,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
