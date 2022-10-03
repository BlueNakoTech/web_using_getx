import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 29, 111, 136),
                    Color.fromARGB(255, 4, 74, 95),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Container(
              width: 800,
              height: 500,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 6, 80, 139),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 4, 31, 107)
                        .withOpacity(0.6), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Material(
                      color: Colors.transparent,
                      child: Text(
                        'Join Us',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Hero(
                          tag: 'dash',
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            color: Colors.transparent,
                            child: const WarCard(),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Hero(
                          tag: 'drop',
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            color: Colors.transparent,
                            child: const WowsCard(),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class WarCard extends StatelessWidget {
  const WarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 300,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Material(
            color: Colors.transparent,
            child: Text(
              '[TKRI]',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage("assets/images/Logo_tKRI.png"),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                Get.toNamed('/warthunderjoin');
              },
              child: const Text('War Thunder')),
        ],
      ),
    );
  }
}

class WowsCard extends StatelessWidget {
  const WowsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 300,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Material(
            color: Colors.transparent,
            child: Text(
              '[TopGradeGunner]',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage("assets/images/ShirokoLogo.png")
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    actionsPadding: const EdgeInsets.all(15),
                    title: const Text("Tidak ada Rekrutmen"),
                    content: const Text("ODIN sedang tidak membuka rekrutmen"),
                    actions: [
                      TextButton(
                          onPressed: (() {
                            Get.back();
                          }),
                          child: const Text("Kembali"))
                    ],
                  ),
                );
              },
              child: const Text('Blue Archive')),
        ],
      ),
    );
  }
}
