import 'login_entry.dart';
import 'signup_entry.dart';
import 'package:flutter/material.dart';
import 'package:orix_food_delivery/classes/Logo.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login';
  FirebaseAuthentication auth;
  FirestoreDB firestoreDB;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    AuthScreenArguments args = ModalRoute.of(context).settings.arguments;
    widget.firestoreDB = args.firestoreDB;
    widget.auth = args.auth;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: kPrimaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottom),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 50.0,
                            spreadRadius: -5.0),
                      ],
                      borderRadius: BorderRadius.circular(45.0),
                      color: kPrimaryColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Image.asset(
                              'resources/images/welcome_icons/food_items_group.png'),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                          child: BrandLogo(),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  0.1 * MediaQuery.of(context).size.width),
                          height: 50.0,
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: kSecondaryColor,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: <Widget>[
                              Tab(
                                  child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.08 *
                                        MediaQuery.of(context).size.width),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      color: Colors.black),
                                ),
                              )),
                              Tab(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.075 *
                                          MediaQuery.of(context).size.width),
                                  child: Text(
                                    'Signup',
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-Bold',
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.38 * MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        LoginEntry(
                            auth: widget.auth, firestoreDB: widget.firestoreDB),
                        SignupEntry(
                            auth: widget.auth, firestoreDB: widget.firestoreDB),
                      ],
                      controller: _tabController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
