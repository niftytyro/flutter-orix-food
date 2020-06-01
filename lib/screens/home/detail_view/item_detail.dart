import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';
import 'package:orix_food_delivery/services/firebase_storage.dart';

class ItemDetail extends StatefulWidget {
  final CachedNetworkImage image;
  final String name;
  final FirestoreDB firestoreDB;
  final FirebaseCloudStorage firebaseCloudStorage;

  ItemDetail(
      {@required this.image,
      @required this.name,
      @required this.firestoreDB,
      @required this.firebaseCloudStorage});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  void initState() {
    // TODO: implement initState get single food item
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BackButton(),
        // Image(image: null),
      ],
    );
  }
}

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 50, 50),
      height: 0.12 * MediaQuery.of(context).size.width,
      width: 0.12 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 10,
            offset: Offset(2, 5),
          )
        ],
      ),
      child: Icon(FontAwesomeIcons.angleLeft),
    );
  }
}
