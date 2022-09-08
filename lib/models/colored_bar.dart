import 'package:flutter/material.dart';

class ColoredBar extends StatelessWidget {
  final Color color;
  const ColoredBar({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 7,
      margin: const EdgeInsets.symmetric(horizontal: 0.7),
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }
}
