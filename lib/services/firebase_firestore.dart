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

  Future<List<FoodItem>> getFoodItems(String tag) async {
    List<FoodItem> items = [];
    if (tag == null) {
      QuerySnapshot snapshot =
          await _firestore.collection("items").getDocuments();
      snapshot.documents.forEach((element) {
        items.add(FoodItem(
            name: element.data['name'],
            calories: element.data['calories'],
            ingredients: element.data['ingredients'],
            rating: element.data['rating'].toDouble(),
            price: element.data['price'].toDouble(),
            tags: element.data['tags'],
            timeToCook: element.data['time_to_cook']));
      });
    } else {
      QuerySnapshot snapshot = await _firestore
          .collection("items")
          .where("tags", arrayContains: tag)
          .getDocuments();
      snapshot.documents.forEach((element) {
        items.add(FoodItem(
            name: element.data['name'],
            calories: element.data['calories'],
            ingredients: element.data['ingredients'],
            rating: element.data['rating'].toDouble(),
            price: element.data['price'].toDouble(),
            tags: element.data['tags'],
            timeToCook: element.data['time_to_cook']));
      });
    }
    return items;
  }

  Future<FoodItem> getSingleFoodItem(String name) async {
    FoodItem item;
    QuerySnapshot snapshot = await _firestore
        .collection("items")
        .where("name", isEqualTo: name)
        .getDocuments();
    snapshot.documents.forEach((element) {
      item = FoodItem(
          name: element.data['name'],
          calories: element.data['calories'],
          ingredients: element.data['ingredients'],
          rating: element.data['rating'].toDouble(),
          price: element.data['price'].toDouble(),
          tags: element.data['tags'],
          timeToCook: element.data['time_to_cook']);
    });
    return item;
  }
}
