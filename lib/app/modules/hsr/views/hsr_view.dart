import 'package:app_using_getx/app/modules/hsr/views/addbanner_view.dart';
import 'package:app_using_getx/shared/custom.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controllers/hsr_controller.dart';

class HsrView extends GetView<HsrController> {
  const HsrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 40,
          onPressed: (() {
            Get.to(() => const AddbannerView());
          }),
          hoverColor: Colors.white30,
          icon: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white24,
          ),
        ),
        backgroundColor: Colors.black45,
        title: Row(
          children: [
            Flexible(
              flex: 1,
              child: Image.asset(
                "assets/images/Honkai_Star_Rail.webp",
                fit: BoxFit.contain,
              ),
            ),
            const Flexible(
              flex: 2,
              child: Text("Character Banner Preferences"),
            ),
          ],
        ),
      ),
      body: Stack(children: [
        const BackgroundImageWidget(),
        Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: SizedBox(
                width: 1600,
                height: double.infinity,
                child: BannerListWidget()))
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isFullWidth = screenWidth >= 1200; // Change this threshold as needed

    final crossAxisCount = isFullWidth ? 2 : 1;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('banner')
          .orderBy('addedDate', descending: true) // Sort by addedDate
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No banners found'));
        }

        var banners = snapshot.data!.docs;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // Number of columns
            crossAxisSpacing: 10, // Spacing between columns
            mainAxisSpacing: 10, // Spacing between rows
            childAspectRatio: 1.5, // Aspect ratio of each item
          ),
          itemCount: banners.length,
          itemBuilder: (context, index) {
            var banner = banners[index];
            return BannerCard(
              bannerId: banner.id,
              name: banner['name'],
              imageUrl: banner['name'],
              va: banner['va'],
              checkboxValues: {
                'v1': banner['v1'] ?? false,
                'v2': banner['v2'] ?? false,
                'v3': banner['v3'] ?? false,
                'v4': banner['v4'] ?? false,
                'v5': banner['v5'] ?? false,
              },
              displayTexts: const {
                'v1': 'Imut',
                'v2': 'Kecil',
                'v3': 'Cantik',
                'v4': 'Suara',
                'v5': 'Imut Banget',
              },
            );
          },
        );
      },
    );
  }
}
