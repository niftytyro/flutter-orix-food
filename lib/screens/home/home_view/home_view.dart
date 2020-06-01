import 'package:flutter/material.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/screens/home/home_view/items_view.dart';
import 'package:orix_food_delivery/screens/home/search_widget.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';
import 'package:orix_food_delivery/services/firebase_storage.dart';

class HomeView extends StatefulWidget {
  final FirebaseAuthentication auth;
  final FirestoreDB firestoreDB;
  final FirebaseCloudStorage firebaseCloudStorage;

  HomeView({
    @required this.firestoreDB,
    @required this.auth,
    @required this.firebaseCloudStorage,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: kSecondaryColor,
                    ),
                    width: 60.0,
                    height: 60.0,
                    child: Image.asset('resources/images/profile_icon.png')),
              ),
              SizedBox(
                height: 0.02 * MediaQuery.of(context).size.height,
              ),
              Container(
                width: 0.6 * MediaQuery.of(context).size.width,
                height: 0.1 * MediaQuery.of(context).size.height,
                child: Text(
                  'Let\'s eat Quality food.',
                  style: kIntroHeader,
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(
                height: 0.025 * MediaQuery.of(context).size.height,
              ),
              SearchWidget(
                onSubmitted: (String searchTerm) {},
              ),
              SizedBox(
                height: 0.025 * MediaQuery.of(context).size.height,
              ),
            ],
          ),
        ),
        ItemsView(
            firebaseCloudStorage: widget.firebaseCloudStorage,
            firestoreDB: widget.firestoreDB)
      ],
    );
  }
}
