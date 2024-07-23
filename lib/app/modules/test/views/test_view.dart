import 'package:app_using_getx/shared/custom.dart';
import 'package:app_using_getx/shared/keypad.dart';
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

class TestCommandForm extends StatefulWidget {
  const TestCommandForm({Key? key}) : super(key: key);

  @override
  State<TestCommandForm> createState() => _TestCommandFormState();
}

class _TestCommandFormState extends State<TestCommandForm> {
  @override
  Widget build(BuildContext context) {
    final TestController controller = Get.put(TestController());
    void handleKeyPressed(String key) {
      controller.runSerialCommand(key);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Command'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: GlobalKey<FormState>(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UniversalButton(
                      color: Colors.grey,
                      buttonText: 'Authenticate',
                      onPressed: () {
                        controller.authenticate();
                      },
                    ),
                    UniversalButton(
                      color: Colors.grey,
                      buttonText: 'Check Conn',
                      onPressed: () {
                        controller.checkStatus();
                      },
                    ),
                  ],
                ),
                Obx(() {
                  controller.clientPinController.text =
                      controller.operationToken.value;
                  return TextFormField(
                    controller: controller.clientPinController,
                    decoration: const InputDecoration(labelText: 'Command'),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UniversalButton(
                        color: Colors.grey,
                        buttonText: 'Send',
                        onPressed: () {
                          controller.runSerialCommand(
                              controller.clientPinController.text);
                        },
                      ),
                      UniversalButton(
                        color: Colors.grey,
                        buttonText: 'Send Multi',
                        onPressed: () {
                          controller.runMultiSerialCommand(
                              controller.clientPinController.text);
                        },
                      ),
                    ]),
                const SizedBox(
                  height: 20,
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
                  onPressed: () {
                    controller.fetchData(controller.operationToken.value);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 200,
                    height: 300,
                    child: Keypad(onKeyPressed: handleKeyPressed))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
