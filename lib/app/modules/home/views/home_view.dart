import 'package:app_using_getx/shared/custom.dart';
import 'package:app_using_getx/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_using_getx/shared/extension.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeViewAdaptiveLayout extends GetView<HomeController> {
  const HomeViewAdaptiveLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.isMobile) {
          return Stack(
            children: [
              const Scaffold(
                backgroundColor: backgroundColor,
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: 800,
                      height: 500,
                      decoration: BoxDecoration(
                        color: primeColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          TitleText(),
                          WarCardMobile(),
                          ArchiveCardMobile(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return Stack(
          children: [
            const Scaffold(
              backgroundColor: backgroundColor,
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 800,
                    height: 500,
                    decoration: BoxDecoration(
                      color: primeColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const TitleText(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            WarCardDesktop(),
                            ArchiveCardDesktop(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Text(
        "Join Us",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class WarCardMobile extends StatelessWidget {
  const WarCardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return CardMobile(
      color: cardColor,
      title: "[TKRI]",
      buttonText: "War Thunder",
      assetImage: "assets/images/Logo_tKRI.png",
      onPressed: () {
        Get.toNamed('/warthunderjoin');
      },
    );
  }
}

class WarCardDesktop extends StatelessWidget {
  const WarCardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return CardDesktop(
      color: cardColor,
      title: "[TKRI]",
      buttonText: "War Thunder",
      assetImage: "assets/images/Logo_tKRI.png",
      onPressed: () {
        Get.toNamed('/warthunderjoin');
      },
    );
  }
}

class ArchiveCardMobile extends StatelessWidget {
  const ArchiveCardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return CardMobile(
      color: cardColor,
      title: "[TopGradeGunner]",
      buttonText: "Blue Archive",
      assetImage: "assets/images/ShirokoLogo.png",
      onPressed: () {},
    );
  }
}

class ArchiveCardDesktop extends StatelessWidget {
  const ArchiveCardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return CardDesktop(
      color: cardColor,
      title: "[TopGradeGunner]",
      buttonText: "Blue Archive",
      assetImage: "assets/images/ShirokoLogo.png",
      onPressed: () {},
    );
  }
}
