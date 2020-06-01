import 'package:flutter/material.dart';
import 'package:orix_food_delivery/screens/home/home_view/selected_tag.dart';
import 'items_carousel.dart';
import 'filter_chips.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';
import 'package:orix_food_delivery/services/firebase_storage.dart';

class ItemsView extends StatefulWidget {
  final FirebaseCloudStorage firebaseCloudStorage;
  final FirestoreDB firestoreDB;

  ItemsView({@required this.firebaseCloudStorage, @required this.firestoreDB});

  @override
  _ItemsViewState createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  final SelectedTag tag = SelectedTag();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          child: FilterChipRow(tagObj: tag, onTap: () => setState(() {}))),
      SizedBox(height: 0.025 * MediaQuery.of(context).size.height),
      ItemsCarousel(
        firestoreDB: widget.firestoreDB,
        storageRef: widget.firebaseCloudStorage,
        tag: tag.tag,
      ),
    ]);
  }
}
