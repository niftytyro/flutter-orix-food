import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orix_food_delivery/classes/food_item.dart';

enum addUserStatus { ALREADY_EXISTS, SUCCESS }

class FirestoreDB {
  final Firestore _firestore = Firestore.instance;

  Future<Map> addUser({String name, String email, String gender}) async {
    addUserStatus status;
    Map validation = getUser(email);
    if ((validation['name'] == null) && (validation['gender'] == null)) {
      await _firestore
          .collection("users")
          .add({'name': name, 'email': email, 'gender': gender});
      status = addUserStatus.SUCCESS;
    } else {
      status = addUserStatus.ALREADY_EXISTS;
      name = validation['name'];
      email = validation['email'];
      gender = validation['gender'];
    }
    return {'status': status, 'name': name, 'email': email, 'gender': gender};
  }

  Map getUser(String email) {
    String name, gender;
    _firestore
        .collection("users")
        .where('users', isEqualTo: email)
        .snapshots()
        .listen((data) {
      if (data.documents.length == 0)
        name = gender = null;
      else {
        name = data.documents[0].data['name'];
        gender = data.documents[0].data['gender'];
      }
    });
    return {'name': name, 'gender': gender, 'email': email};
  }

  Future<List> getFoodItems() async {
    List<FoodItem> items = [];
    _firestore.collection("items").snapshots().listen((snapshot) {
      snapshot.documents.forEach((element) {
        items.add(FoodItem(
            name: element.data['name'],
            calories: element.data['calories'],
            ingredients: element.data['ingredients'],
            rating: element.data['rating'],
            price: element.data['price'],
            tags: element.data['tags'],
            timeToCook: element.data['time_to_cook']));
      });
    });
    return items;
  }
}
