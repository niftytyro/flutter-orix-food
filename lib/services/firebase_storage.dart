import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCloudStorage {
  var _storage = FirebaseStorage.instance;

  Future<String> getDownloadUrl({String title, String dir}) async {
    print('______________________________________________');
    print('$dir/$title.png');
    return await _storage.ref().child('$dir/$title.png').getDownloadURL();
  }
}
