import 'package:flutter/material.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/custom_icons.dart';
import 'package:orix_food_delivery/screens/home/detail_view/item_detail.dart';
import 'package:orix_food_delivery/screens/home/home_view/home_view.dart';
import 'package:orix_food_delivery/screens/home/navigation_bar.dart';
import 'package:orix_food_delivery/screens/home/notifications_view/notifications_view.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';
import 'package:orix_food_delivery/services/firebase_storage.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';
  FirebaseAuthentication _auth;
  FirestoreDB _firestoreDB;
  final FirebaseCloudStorage _firebaseCloudStorage = FirebaseCloudStorage();
  bool first = true;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode _node;
  Widget display;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
  }

  void setHomeView() {
    display = HomeView(
        firestoreDB: widget._firestoreDB,
        auth: widget._auth,
        firebaseCloudStorage: widget._firebaseCloudStorage);
  }

  void setNotificationsView() {
    display = NotificationsView();
  }

  @override
  Widget build(BuildContext context) {
    AuthScreenArguments args = ModalRoute.of(context).settings.arguments;
    widget._auth = args.auth;
    widget._firestoreDB = args.firestoreDB;
    if (widget.first) {
      setHomeView();
      widget.first = false;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: kPrimaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_node);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          reverse: true,
          child: Container(
            margin: EdgeInsets.only(top: 30.0),
            child: ItemDetail(),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(icons: [
        [CustomIcons.shopping_bag, () {}],
        [
          CustomIcons.home_outline,
          () {
            setState(() {
              setHomeView();
            });
          },
        ],
        [
          CustomIcons.notification_outline,
          () {
            setState(() {
              setNotificationsView();
            });
          }
        ]
      ]),
    );
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }
}
