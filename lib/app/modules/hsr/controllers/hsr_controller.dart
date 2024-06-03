import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HsrController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      return 'Special Case : $bannerVa'; // Special case for voice actress names
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
