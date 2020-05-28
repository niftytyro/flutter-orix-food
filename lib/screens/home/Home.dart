import 'package:flutter/material.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home';
  FirebaseAuthentication _auth;
  FirestoreDB _firestoreDB;
  String _uid;

  @override
  Widget build(BuildContext context) {
    AuthScreenArguments args = ModalRoute.of(context).settings.arguments;
    _auth = args.auth;
    _firestoreDB = args.firestoreDB;
    return Scaffold(
      body: Center(
          child: Text(_auth.getCurrentUser().toString(),
              style: TextStyle(fontSize: 35.0))),
    );
  }
}
