import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormviewView extends GetView<FormController> {
  const FormviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Formulir Pendaftaran',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller.namaController,
              onChanged: (_) => controller.validateFields(),
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                label: const Text("Nama Panggilan"),
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(fontSize: 12, color: Colors.white),
              textAlignVertical: TextAlignVertical.bottom,
            ),
            TextFormField(
              controller: controller.nickController,
              onChanged: (_) => controller.validateFields(),
              decoration: InputDecoration(
                label: const Text("WT nickname"),
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(fontSize: 12, color: Colors.white),
              textAlignVertical: TextAlignVertical.bottom,
            ),
            TextFormField(
              controller: controller.userController,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => controller.validateFields(),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                label: const Text("Discord Username"),
                hintText: 'frostnii',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(fontSize: 12, color: Colors.white),
              textAlignVertical: TextAlignVertical.bottom,
            ),
            TextFormField(
              controller: controller.negaraController,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => controller.validateFields(),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                label: const Text("Tech Tree / BR"),
                hintText: 'Italy 11.7, Germany 11.0. dst',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(fontSize: 12, color: Colors.white),
              textAlignVertical: TextAlignVertical.bottom,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 334),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => Checkbox(
                        value: controller.sbChecked.value,
                        onChanged: (value) {
                          controller.sbChecked(value);
                        },
                      )),
                  const Expanded(
                      child: Text(
                    'Saya Siap Mengikuti Squadron Realistic Battle',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  )),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.rulesChecked.value,
                      onChanged: (value) {
                        controller.rulesChecked(value);
                      },
                    ),
                  ),
                  const Expanded(
                      child: Text(
                    'Saya Sudah Membaca dan Setuju Peraturan yg tertulis',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Obx(() => Container(
                  width: Get.width,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: controller.rulesChecked.value &&
                              controller.sbChecked.value &&
                              controller.isButtonEnabled.value
                          ? () {
                              controller.addFormulir(
                                controller.namaController.text,
                                controller.nickController.text,
                                controller.negaraController.text.toUpperCase(),
                                controller.userController.text.toLowerCase(),
                              );
                              Get.defaultDialog(
                                title: '',
                                backgroundColor: Colors.transparent,
                                barrierDismissible: false,
                                middleText:
                                    "Untuk Proses lebih lanjut bisa langsung join Discord server kami",
                                content: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  actionsPadding: const EdgeInsets.all(30),
                                  title: const Text("Formulir Terkirim"),
                                  content: const Text(
                                      "Untuk Proses lebih lanjut bisa langsung join Discord server kami"),
                                  actions: [
                                    TextButton(
                                        onPressed: (() {
                                          controller.formSend(false, false);
                                          Get.toNamed('/home');
                                        }),
                                        child: const Text("OK")),
                                    // IconButton(
                                    //     // ignore: prefer_const_constructors
                                    //     icon: Icon(
                                    //       Icons.discord,
                                    //     ),
                                    //     onPressed: () {
                                    //       controller.discordUrl();
                                    //       controller.formSend(false, false);

                                    //     })
                                  ],
                                ),
                              );
                            }
                          : null,
                      child: const Text('Kirim')),
                )),
          ],
        ),
      ),
    );
  }
}
