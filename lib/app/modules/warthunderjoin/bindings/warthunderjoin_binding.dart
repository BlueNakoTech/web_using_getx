import 'package:get/get.dart';

import 'package:app_using_getx/app/modules/warthunderjoin/controllers/form_controller.dart';
import 'package:app_using_getx/app/modules/warthunderjoin/controllers/rules_controller.dart';

import '../controllers/warthunderjoin_controller.dart';

class WarthunderjoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormController>(
      () => FormController(),
    );
    Get.lazyPut<RulesController>(
      () => RulesController(),
    );
    Get.lazyPut<WarthunderjoinController>(
      () => WarthunderjoinController(),
    );
  }
}
