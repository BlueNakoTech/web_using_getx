import 'package:flutter/material.dart';

class Keypad extends StatelessWidget {
  final void Function(String) onKeyPressed;

  Keypad({super.key, required this.onKeyPressed});

  final List<String> keys = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'h',
    '0',
    'c'
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonSize = screenSize.width / 3 - 20;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(20.0),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        return KeypadButton(
          label: keys[index],
          size: buttonSize,
          onPressed: () {
            onKeyPressed(keys[index]);
          },
        );
      },
    );
  }
}

class KeypadButton extends StatelessWidget {
  final String label;
  final double size;
  final VoidCallback onPressed;

  const KeypadButton(
      {super.key,
      required this.label,
      required this.size,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
