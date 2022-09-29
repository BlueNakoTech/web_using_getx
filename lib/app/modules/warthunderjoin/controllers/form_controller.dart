import 'dart:ffi';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  late TextEditingController namaController;
  late TextEditingController nickController;
  late TextEditingController negaraController;
  late TextEditingController userController;
  var isruleschecked;
  var issbchecked;

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
    isruleschecked = bool;
    issbchecked = bool;
  }
}
