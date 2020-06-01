import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:orix_food_delivery/screens/home/home_view/selected_tag.dart';
import 'package:orix_food_delivery/screens/home/item_card.dart';
import 'package:orix_food_delivery/classes/food_item.dart';
import 'package:orix_food_delivery/services/firebase_storage.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';

class ItemsCarousel extends StatefulWidget {
  final FirebaseCloudStorage storageRef;
  final FirestoreDB firestoreDB;
  final String tag;

  ItemsCarousel(
      {@required this.storageRef, @required this.firestoreDB, this.tag});

  @override
  _ItemsCarouselState createState() => _ItemsCarouselState();
}

class _ItemsCarouselState extends State<ItemsCarousel> {
  Future _future;

  Future<List> _getAllItems() async {
    var items = await widget.firestoreDB.getFoodItems(widget.tag);
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = _getAllItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('---------------Snapshot-------------------');
          if (snapshot.connectionState == ConnectionState.done) {
            // try {
            return Container(
              margin: EdgeInsets.only(top: 20.0),
              child: CarouselSlider.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data[index].name);
                  return ItemCard(
                    title: snapshot.data[index].name,
                    calories: snapshot.data[index].calories,
                    price: snapshot.data[index].price.toString(),
                    storageRef: widget.storageRef,
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  aspectRatio: 1.5,
                  viewportFraction: 0.55,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  height: 0.375 * MediaQuery.of(context).size.height,
                ),
              ),
            );
            // } catch (e) {
            //   print(e);
            //   return Column(
            //     children: <Widget>[
            //       SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
            //       CircularProgressIndicator(),
            //     ],
            //   );
            // }
          } else {
            return Container(
              height: 0.375 * MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
