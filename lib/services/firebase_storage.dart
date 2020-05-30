import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCloudStorage {
  var _storage = FirebaseStorage.instance;

  Future<String> getDownloadUrl(String imageTitle) async {
    return await _storage.ref().child(imageTitle).getDownloadURL();
  }
}
