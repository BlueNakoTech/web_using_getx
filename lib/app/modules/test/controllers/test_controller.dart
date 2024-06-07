import 'dart:convert';
import 'dart:typed_data';

import 'package:app_using_getx/app/modules/hsr/controllers/api_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  var result = ''.obs;
  var imageFile = Rx<Uint8List?>(null);
  final ApiService apiService = ApiService();
  final TextEditingController commandController = TextEditingController();
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController clientPinController = TextEditingController();

  Future<void> authenticate() async {
    const clientid = "client02";
    const clientpin = "123789";
    try {
      await apiService.authenticate(
        clientid,
        clientpin,
      );
      result.value = 'Authenticated';
    } catch (e) {
      result.value = 'Authentication failed: $e';
    }
  }

  Future<void> checkCorsStatus() async {
    try {
      await apiService.allowCors();
    } catch (e) {
      result.value = 'Error: $e';
    }
  }

  Future<void> checkStatus() async {
    try {
      final data = await apiService.checkStatus();
      result.value = 'Status: ${data['status']}';
    } catch (e) {
      result.value = 'Error: $e';
    }
  }

  Future<void> runCaptureCommand() async {
    try {
      final data = await apiService.runCaptureCommand();
      result.value = data['result'];
      imageFile.value = base64Decode(data['base64Image']);
    } catch (e) {
      result.value = 'Error: $e';
      imageFile.value = null;
    }
  }

  Future<void> runSerialCommand(String pin) async {
    try {
      final data = await apiService.runSerialCommand(pin);
      result.value = data['result'];
      imageFile.value = base64Decode(data['base64Image']);
    } catch (e) {
      result.value = 'Error: $e';
      imageFile.value = null;
    }
  }

  Future<void> fetchData(String key) async {
    try {
      final data = await apiService.getData(key);
      result.value = data['result'];
      imageFile.value = base64Decode(data['base64Image']);
    } catch (e) {
      result.value = 'Error: $e';
      imageFile.value = null;
    }
  }

  @override
  void onClose() {
    commandController.dispose();
    clientIdController.dispose();
    clientPinController.dispose();
    super.onClose();
  }
}
