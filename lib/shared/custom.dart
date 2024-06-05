import 'dart:async';

import 'package:app_using_getx/app/modules/hsr/controllers/hsr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardMobile extends StatelessWidget {
  const CardMobile({
    Key? key,
    void Function()? onPressed,
    required Color color,
    required String title,
    required String buttonText,
    required String assetImage,
  })  : _onPressed = onPressed,
        _title = title,
        _buttonText = buttonText,
        _assetImage = assetImage,
        super(key: key);

  final Function()? _onPressed;
  final Color color = const Color(0xFF1D49A1);
  final String _title;
  final String _assetImage;
  final String _buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(_assetImage),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      _title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: _onPressed,
                      child: Text(_buttonText)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardDesktop extends StatelessWidget {
  const CardDesktop({
    Key? key,
    void Function()? onPressed,
    required Color color,
    required String title,
    required String buttonText,
    required String assetImage,
  })  : _onPressed = onPressed,
        _title = title,
        _buttonText = buttonText,
        _assetImage = assetImage,
        super(key: key);

  final Function()? _onPressed;
  final Color color = const Color(0xFF1D49A1);
  final String _title;
  final String _assetImage;
  final String _buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 350,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Material(
                color: Colors.transparent,
                child: Text(
                  _title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(_assetImage),
              ),
            ),
            Flexible(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: _onPressed,
                  child: Text(_buttonText)),
            ),
          ],
        ),
      ),
    );
  }
}

class UniversalButton extends StatelessWidget {
  const UniversalButton(
      {Key? key,
      void Function()? onPressed,
      required Color color,
      required String buttonText})
      : _onPressed = onPressed,
        // _title = title,
        _buttonText = buttonText,
        super(key: key);

  final Function()? _onPressed;
  final Color color = const Color(0xFF1D49A1);
  // final String _title;
  final String _buttonText;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: _onPressed,
          child: Text(_buttonText)),
    );
  }
}

class BannerCard extends StatefulWidget {
  final String name;
  final String bannerId;
  final String imageUrl; // This is the path in Firebase Storage
  final String va;
  final Map<String, bool> checkboxValues;
  final Map<String, String> displayTexts;

  const BannerCard({
    super.key,
    required this.name,
    required this.va,
    required this.imageUrl,
    required this.bannerId,
    required this.checkboxValues,
    required this.displayTexts,
  });

  @override
  State<BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<BannerCard> {
  late Future<String> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    final HsrController controller = Get.find();
    _imageUrlFuture = controller.fetchImageUrl(widget.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    final HsrController controller = Get.find();

    String pullStrategy =
        controller.determinePullStrategy(widget.checkboxValues, widget.va);

    return Card(
      color: Colors.transparent.withOpacity(0.5),
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "JP VA : ${widget.va}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FutureBuilder<String>(
                    future: _imageUrlFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      } else if (!snapshot.hasData) {
                        return const Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      } else {
                        print(snapshot.data);
                        return Image.network(
                          snapshot.data!,
                          fit: BoxFit.contain,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.checkboxValues.keys.map((key) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.displayTexts[key]!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                              // Color of the checkbox when it is not selected
                            ),
                            child: Checkbox(
                              value: widget.checkboxValues[key],
                              onChanged: (bool? value) {
                                if (value != null) {
                                  controller.updateCheckboxValue(
                                      widget.bannerId, key, value);
                                }
                              },
                              activeColor: Colors.grey,
                              // Color of the checkbox
                              checkColor: Colors.yellowAccent,
                              // Color of the check mark
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            PullStrategyBox(pullStrategy: pullStrategy),
          ],
        ),
      ),
    );
  }
}

class PullStrategyBox extends StatelessWidget {
  final String pullStrategy;

  const PullStrategyBox({Key? key, required this.pullStrategy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HsrController());
    Color backgroundColor =
        _getBackgroundColor(pullStrategy, controller.voiceActressNames);
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          pullStrategy,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Color _getBackgroundColor(
      String pullStrategy, List<String> voiceActressNames) {
    switch (pullStrategy) {
      case 'Skip':
        return Colors.grey;
      case 'Maybe':
        return Colors.yellow;
      case 'Pull':
        return Colors.blue;
      case 'All In':
        return Colors.green;
      default:
        // Check if it's a special case for voice actress names
        for (var name in voiceActressNames) {
          if (pullStrategy.startsWith('Special Case All In: $name')) {
            return Colors.redAccent;
          }
        }
        // Default color for unknown cases
        return Colors.transparent;
    }
  }
}
