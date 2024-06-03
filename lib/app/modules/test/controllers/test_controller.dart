import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  Future<String> fetchImageUrl(String path) async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child('hsr-banner').child("$path.jpg");
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error fetching image URL: $e');
      rethrow;
    }
  }
}
