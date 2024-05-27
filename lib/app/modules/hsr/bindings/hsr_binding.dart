import 'package:get/get.dart';

import '../controllers/hsr_controller.dart';

class HsrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HsrController>(
      () => HsrController(),
    );
  }
}
