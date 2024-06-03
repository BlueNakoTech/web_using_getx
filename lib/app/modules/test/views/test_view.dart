import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestView'),
        centerTitle: true,
      ),
      body: Center(
          child: Image.network(
              'https://pbs.twimg.com/media/GL0kJ5dawAAGIkZ?format=jpg&name=medium',
              loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          print(loadingProgress.cumulativeBytesLoaded);
          return CircularProgressIndicator(
              value: loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!);
        }
        return child;
      })),
    );
  }
}
