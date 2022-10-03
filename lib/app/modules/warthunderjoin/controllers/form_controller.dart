import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  late TextEditingController namaController;
  late TextEditingController nickController;
  late TextEditingController negaraController;
  late TextEditingController userController;
  final rulesChecked = false.obs;
  final sbChecked = false.obs;
  late Uri url;
  final invite = 'https://discord.gg/8Vq6sBGQVH'.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addFormulir(
    String nama,
    String nick,
    String negara,
    String user,
  ) async {
    CollectionReference formulir = firestore.collection('Formulir');

    formulir.add({
      'Nama': nama,
      'nickname': nick,
      'Negara': negara,
      'Discord': user,
    });
  }

  @override
  void onInit() {
    namaController = TextEditingController();
    nickController = TextEditingController();
    negaraController = TextEditingController();
    userController = TextEditingController();
    url = Uri.parse('$invite');
    super.onInit();
  }

  @override
  void onClose() {
    namaController.dispose();
    nickController.dispose();
    negaraController.dispose();
    userController.dispose();

    super.onClose();
  }

  void formSend(
    bool isRulesChecked,
    bool isSbChecked,
  ) {
    namaController.clear();
    negaraController.clear();
    nickController.clear();
    userController.clear();
    rulesChecked(isRulesChecked);
    sbChecked(isSbChecked);
  }

  void discordUrl() async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
