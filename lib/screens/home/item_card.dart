import 'package:flutter/material.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/screens/home/detail_view/item_detail.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';
import 'package:orix_food_delivery/services/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemCard extends StatefulWidget {
  CachedNetworkImage image;
  final String title;
  final int calories;
  final String price;
  final FirebaseCloudStorage storageRef;
  final FirestoreDB firestoreDB;

  ItemCard(
      {@required this.calories,
      @required this.price,
      @required this.title,
      @required this.storageRef,
      @required this.firestoreDB});

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  Future<void> fetchImageUrl() async {
    try {
      String imageUrl = await widget.storageRef
          .getDownloadUrl(title: widget.title, dir: 'items');
      if (mounted) {
        setState(() {
          widget.image = CachedNetworkImage(
            imageUrl: imageUrl,
            // placeholder: (BuildContext context, String data) {
            //   return CircularProgressIndicator();
            // },
          );
          print('2');
          print(mounted);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String readPrice() {
    int decimalPos = widget.price.indexOf('.');
    if (widget.price.substring(decimalPos + 1).length == 1) {
      return widget.price + '0';
    }
    return widget.price;
  }

  @override
  Widget build(BuildContext context) {
    fetchImageUrl();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetail(
                      name: widget.title,
                      image: widget.image,
                      firestoreDB: widget.firestoreDB,
                    )));
      },
      child: LayoutBuilder(
        builder: (BuildContext _context, BoxConstraints constraints) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20.0)),
                  height: 0.8 * constraints.maxHeight,
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      verticalDirection: VerticalDirection.up,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\$ ',
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      fontFamily: 'Gilroy',
                                      fontSize: 18.0)),
                              TextSpan(
                                  text: readPrice(),
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      color: kDarkBlack,
                                      fontSize: 32.0)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.calories.toString() + ' Calories',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              color: Colors.red,
                              fontSize: 10.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          constraints: BoxConstraints.loose(Size(
                              0.4 * MediaQuery.of(context).size.width, 35.0)),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Bold',
                                fontSize: 18.0,
                                color: kDarkBlack),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child:
                    // widget.image != null
                    Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x55000000),
                          blurRadius: 50.0,
                          spreadRadius: -40.0,
                          offset: Offset(5, 15))
                    ],
                  ),
                  height: 0.55 * constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Container(
                    height: 0.5 * constraints.maxHeight,
                    width: 0.4 * constraints.maxWidth,
                    constraints: BoxConstraints.loose(Size(
                        0.5 * constraints.maxHeight,
                        0.4 * constraints.maxWidth)),
                    child: widget.image,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
