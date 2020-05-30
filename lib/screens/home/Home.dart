import 'package:flutter/material.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/screens/home/home_view/home_view.dart';
import 'package:orix_food_delivery/screens/home/navigation_bar.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuthentication _auth;
  FirestoreDB _firestoreDB;
  String _uid;
  FocusNode _node;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    AuthScreenArguments args = ModalRoute.of(context).settings.arguments;
    _auth = args.auth;
    _firestoreDB = args.firestoreDB;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_node);
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              HomeView(),
              NavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }
}
