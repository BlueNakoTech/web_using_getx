

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormviewView extends GetView<FormController> {
  const FormviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            TextField(
              controller: controller.namaController,
              onEditingComplete: () {},
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
            TextField(
              controller: controller.nickController,
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
            TextField(
              controller: controller.negaraController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                label: const Text("Negara utama"),
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(fontSize: 12, color: Colors.white),
              textAlignVertical: TextAlignVertical.bottom,
            ),
            TextField(
              controller: controller.userController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                label: const Text("Discord"),
                hintText: 'Nicama#9958',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(fontSize: 12, color: Colors.white),
              textAlignVertical: TextAlignVertical.bottom,
            ),
            const SizedBox(
              height: 40,
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
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 334),
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
            Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(260, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: controller.rulesChecked.value &&
                        controller.sbChecked.value
                    ? () {
                        controller.addFormulir(
                          controller.namaController.text,
                          controller.nickController.text,
                          controller.negaraController.text,
                          controller.userController.text,
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

                                    Get.defaultDialog(
                                      title: 'Join Server DISCORD kami untuk mempercepat proses ACC',
                                      middleText: 'Tidak akan kami ACC jika tidak join Server DISCORD',
                                      textConfirm: 'OK',
                                      barrierDismissible: false,
                                      onConfirm: () {
                                        controller.discordUrl();
                                       Get.toNamed('/home');
                                      },

                                    );
                                  }),
                                  child: const Text("OK")),
                              IconButton(
                                // ignore: prefer_const_constructors
                                icon: Icon(
                                  Icons.discord,
                                ),
                                onPressed: () { 
                                  controller.discordUrl();
                                  controller.formSend(false, false);
                                  Get.toNamed('/home');
                                  

                                  }
                              )
                            ],
                          ),
                        );
                      }
                    : null,
                child: const Text('Kirim'))),
          ],
        ),
      ),
    );
  }
}
