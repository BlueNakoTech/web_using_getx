import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  late TextEditingController namaController;
  late TextEditingController nickController;
  late TextEditingController negaraController;
  late TextEditingController userController;
  final rulesChecked = false.obs;
  final sbChecked = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addFormulir(
    String nama,
    String nick,
    String negara,
    String user,
  ) async {
    CollectionReference formulir = firestore.collection('Formulir');

    formulir.add({
      'Nama Panggilan': nama,
      'WT nickname': nick,
      'Negara utama': negara,
      'Discord': user,
    });
  }

  @override
  void onInit() {
    namaController = TextEditingController();
    nickController = TextEditingController();
    negaraController = TextEditingController();
    userController = TextEditingController();
    super.onInit();
  }

  void isChecked(
    bool isRulesChecked,
    bool isSbChecked,
  ) {
    rulesChecked(isRulesChecked);
    sbChecked(isSbChecked);
  }
}
