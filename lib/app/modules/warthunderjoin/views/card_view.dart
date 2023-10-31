import 'package:app_using_getx/app/modules/warthunderjoin/controllers/warthunderjoin_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CardView extends GetView {
  const CardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WarthunderjoinController());
    return FittedBox(
      child: Container(
        color: Colors.transparent,
        height: 150,
        width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage("assets/images/Logo_QED.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Material(
                  color: Colors.transparent,
                  child: Text(
                    'Q.E.D',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      Get.toNamed('/home');
                    },
                    child: const Text('Back')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
