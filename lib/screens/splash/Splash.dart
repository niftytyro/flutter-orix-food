import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orix_food_delivery/classes/Logo.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/screens/home/Home.dart';
import 'package:orix_food_delivery/screens/login/Login.dart';
import 'package:orix_food_delivery/screens/welcome/Welcome.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  static const id = '/splash';
  FirebaseAuthentication _auth = FirebaseAuthentication();
  FirestoreDB _firestoreDB = FirestoreDB();

  @override
  Widget build(BuildContext context) {
    isFirstLaunch().then((res) {
      if (res) {
        sleep(Duration(seconds: 3));
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeScreen.id, (route) => false,
            arguments:
                AuthScreenArguments(auth: _auth, firestoreDB: _firestoreDB));
      } else {
        _auth.getCurrentUser().then((user) {
          if ((user != null) && (user.uid != null)) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.id, (route) => false,
                arguments: AuthScreenArguments(
                    auth: _auth, firestoreDB: _firestoreDB));
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.id, (route) => false,
                arguments: AuthScreenArguments(
                    auth: _auth, firestoreDB: _firestoreDB));
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45.0),
            color: kPrimaryColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
          child: BrandLogo(),
        ),
      ),
    );
  }

  Future<bool> isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    bool isFirst = prefs.getBool('firstLaunch') ?? true;
    prefs.setBool('firstLaunch', false);

    return isFirst;
  }
}
