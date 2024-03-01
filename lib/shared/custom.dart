import 'package:flutter/material.dart';

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
