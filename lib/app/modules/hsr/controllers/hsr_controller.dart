import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:path/path.dart' as path;

class HsrController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final nameController = TextEditingController();
  final vaController = TextEditingController();
  var v1 = false.obs;
  var v2 = false.obs;
  var v3 = false.obs;
  var v4 = false.obs;
  var v5 = false.obs;
  var imageFile = Rx<Uint8List?>(null);
  var isLoading = false.obs;
  var imageName = ''.obs;
  // Observable list to store banners
  var banner = <DocumentSnapshot>[].obs;
  // var voiceActressNames = <String>[].obs;
  final List<String> voiceActressNames = [
    'Tomori Kusunoki',
    'Ayana Taketatsu',
    'Konomi Kohara',
    'Hayami Saori',
    'Touyama Nao'

    // Add more names as needed
  ];

  @override
  void onInit() {
    super.onInit();

    // fetchVoiceActressNames();
    fetchBanners();
  }

  Future<void> addCharacter() async {
    isLoading.value = true;

    if (imageFile.value != null) {
      await uploadImage(imageFile.value!, imageName.value);
    }

    try {
      await FirebaseFirestore.instance.collection('banner').add({
        'name': nameController.text,
        'va': vaController.text,
        'v1': false,
        'v2': false,
        'v3': false,
        'v4': false,
        'v5': false,
        'addedDate': Timestamp.now(),
      });

      Get.snackbar('Success', 'Character added successfully',
          snackPosition: SnackPosition.BOTTOM);
      resetForm();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add character: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadImage(Uint8List imageData, String imageName) async {
    try {
      String fileName = imageName;
      Reference ref =
          FirebaseStorage.instance.ref().child('hsr-banner').child(fileName);

      // Determine content type based on file extension
      String contentType = _getContentType(fileName);

      final metadata = SettableMetadata(contentType: contentType);

      UploadTask uploadTask = ref.putData(imageData, metadata);
      await uploadTask;
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  String _getContentType(String fileName) {
    String extension = path.extension(fileName).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.webp':
        return 'image/webp';
      default:
        return 'application/octet-stream'; // Fallback for unknown types
    }
  }

  Future<void> pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();

        reader.onLoadEnd.listen((event) {
          imageFile.value = reader.result as Uint8List;
          imageName.value = file.name;
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  void resetForm() {
    nameController.clear();
    vaController.clear();
    imageFile.value = null;
    imageName.value = '';
  }

  Future<String> fetchImageUrl(String path) async {
    final List<String> extensions = ['jpg', 'webp', 'png'];
    for (var ext in extensions) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('hsr-banner')
            .child('$path.$ext');
        return await ref.getDownloadURL();
      } catch (e) {
        // Continue to the next extension if the current one fails
      }
    }
    throw Exception('No valid image found for path: $path');
  }

  String determinePullStrategy(
      Map<String, bool> checkboxValues, String bannerVa) {
    int selectedCount = checkboxValues.values.where((value) => value).length;
    bool hasSpecialName = voiceActressNames.contains(bannerVa);

    if (hasSpecialName) {
      return 'Special Case All In: $bannerVa'; // Special case for voice actress names
    }

    if (selectedCount == 0) {
      return 'Skip'; // Skip pulling the banner
    } else if (selectedCount <= 2) {
      return 'Maybe'; // Pull the banner with a limit
    } else if (selectedCount <= 4) {
      return 'Pull';
    } else {
      return 'All In'; // Pull all the content without limits
    }
  }

  // Fetch banners from Firestore
  void fetchBanners() {
    _firestore.collection('banner').snapshots().listen((snapshot) {
      banner.value = snapshot.docs;
    });
  }

  // Update checkbox value in Firestore
  void updateCheckboxValue(String bannerId, String key, bool value) {
    _firestore.collection('banner').doc(bannerId).update({key: value});
  }
}
