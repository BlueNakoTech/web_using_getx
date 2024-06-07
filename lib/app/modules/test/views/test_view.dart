import 'package:app_using_getx/shared/custom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestView extends GetView {
  const TestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const TestCommandForm();
  }
}

class TestCommandForm extends StatelessWidget {
  const TestCommandForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TestController controller = Get.put(TestController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Command'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: GlobalKey<FormState>(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UniversalButton(
                color: Colors.grey,
                buttonText: 'Authenticate',
                onPressed: () {
                  controller.authenticate();
                },
              ),
              TextFormField(
                controller: null,
                decoration: const InputDecoration(labelText: 'Command'),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              UniversalButton(
                color: Colors.grey,
                buttonText: 'Send',
                onPressed: () {
                  controller.checkCorsStatus();
                },
              ),
              Obx(() {
                if (controller.imageFile.value != null) {
                  return Column(
                    children: [
                      Image.memory(
                        controller.imageFile.value!,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                } else {
                  return Container(
                      height: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: const Text('No'));
                }
              }),
              UniversalButton(
                color: Colors.grey,
                buttonText: "Get Image",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
