import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  final _storageInstance = FirebaseStorage.instance;

  Future<String> uploadImage(String path, File image) async {
    final ref = _storageInstance.ref(path);
    bool success = false;
    late final String returnString;
    try {
      await ref.putFile(image);
      success = true;
    } catch (e) {
      log(e.toString());
    }

    if(success) {
      returnString = await ref.getDownloadURL();
    }

    return returnString;
  }
}