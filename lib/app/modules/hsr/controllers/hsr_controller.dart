import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HsrController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list to store banners
  var banner = <DocumentSnapshot>[].obs;
  final List<String> voiceActressNames = [
    'Tomori Kusunoki',
    'Ayana Taketatsu',
    'Konomi Kohara',

    // Add more names as needed
  ];

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  String determinePullStrategy(
      Map<String, bool> checkboxValues, String bannerVa) {
    int selectedCount = checkboxValues.values.where((value) => value).length;
    bool hasSpecialName = voiceActressNames.contains(bannerVa);

    if (hasSpecialName) {
      return 'Special VA Override : Pull at Any Cost'; // Special case for voice actress names
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
