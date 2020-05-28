import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/screens/Home.dart';
import 'package:orix_food_delivery/screens/Login.dart';
import 'package:orix_food_delivery/screens/Splash.dart';
import 'package:orix_food_delivery/screens/Welcome.dart';

void main() {
  runApp(OrixFoodApp());
}

class OrixFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent));
    return MaterialApp(
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
      initialRoute: SplashScreen.id,
      title: kAppName,
    );
  }
}
