import 'package:app_using_getx/shared/custom.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controllers/hsr_controller.dart';

class HsrView extends GetView<HsrController> {
  const HsrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(children: [
        BackgroundImageWidget(),
        SizedBox(width: 800, height: double.infinity, child: BannerListWidget())
      ]),
    );
  }
}

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/background.webp'), // Ensure the image is in the assets folder
          fit: BoxFit.cover, // This makes the image flexible
        ),
      ),
    );
  }
}

class BannerListWidget extends StatelessWidget {
  const BannerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('banner').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No banners found'));
        }

        var banners = snapshot.data!.docs;
        return SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              var banner = banners[index];
              return BannerCard(
                bannerId: banner.id,
                name: banner['name'],
                imageUrl: banner['url'],
                va: banner['va'],
                checkboxValues: {
                  'v1': banner['v1'] ?? false,
                  'v2': banner['v2'] ?? false,
                  'v3': banner['v3'] ?? false,
                  'v4': banner['v4'] ?? false,
                  'v5': banner['v5'] ?? false,
                },
                displayTexts: {
                  'v1': 'Cute AF',
                  'v2': 'Small Size',
                  'v3': 'Design',
                  'v4': 'Personality',
                  'v5': 'Voice',
                },
              );
            },
          ),
        );
      },
    );
  }
}
