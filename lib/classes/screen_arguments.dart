import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';

class AuthScreenArguments {
  final FirebaseAuthentication auth;
  final FirestoreDB firestoreDB;

  AuthScreenArguments({this.auth, this.firestoreDB});
}
