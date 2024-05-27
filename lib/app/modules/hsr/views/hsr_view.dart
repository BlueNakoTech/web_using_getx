import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controllers/hsr_controller.dart';

class HsrView extends GetView<HsrController> {
  const HsrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageWidget(child: BannerListWidget()),
    );
  }
}

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;

  BackgroundImageWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/background.webp'), // Ensure the image is in the assets folder
          fit: BoxFit.cover, // This makes the image flexible
        ),
      ),
      child: child,
    );
  }
}

class BannerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('banner').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No banners found'));
        }

        var banners = snapshot.data!.docs;
        return ListView.builder(
          itemCount: banners.length,
          itemBuilder: (context, index) {
            var banner = banners[index];
            return BannerCard(
              name: banner['name'],
              imageUrl: banner['url'],
            );
          },
        );
      },
    );
  }
}

class BannerCard extends StatelessWidget {
  final String name;

  final String imageUrl;

  BannerCard({
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;

  const NetworkImageWithFallback({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(imageUrl),
      builder: (context, AsyncSnapshot<Image> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 200,
            color: Colors.grey[300],
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Container(
            height: 200,
            color: Colors.grey[300],
            child: Center(child: Icon(Icons.error)),
          );
        }
        return snapshot.data ?? Container();
      },
    );
  }

  Future<Image> _loadImage(String url) async {
    try {
      final networkImage = NetworkImage(url);
      final completer = Completer<ImageInfo>();
      networkImage.resolve(const ImageConfiguration()).addListener(
            ImageStreamListener(
              (ImageInfo info, bool _) => completer.complete(info),
              onError: (dynamic error, StackTrace? stackTrace) =>
                  completer.completeError(error),
            ),
          );
      await completer.future;
      return Image.network(url,
          fit: BoxFit.cover, width: double.infinity, height: 200);
    } catch (e) {
      throw Exception('Error loading image');
    }
  }
}
