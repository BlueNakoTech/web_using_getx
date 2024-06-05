import 'package:app_using_getx/shared/custom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hsr_controller.dart';

class AddbannerView extends GetView {
  const AddbannerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const AddCharacterForm();
  }
}

class AddCharacterForm extends StatelessWidget {
  const AddCharacterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HsrController controller = Get.put(HsrController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Character'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: GlobalKey<FormState>(),
          child: Container(
            alignment: Alignment.topCenter,
            width: 500,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller.vaController,
                  decoration: const InputDecoration(labelText: 'Voice Actress'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a voice actress name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: UniversalButton(
                    color: Colors.grey,
                    buttonText: 'Pick Image',
                    onPressed: () => controller.pickImage(),
                  ),
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
                        child: const Text('No image selected'));
                  }
                }),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return Container(
                      width: double.infinity,
                      child: UniversalButton(
                        color: Colors.grey,
                        buttonText: "Add",
                        onPressed: () {
                          controller.addCharacter();
                        },
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
