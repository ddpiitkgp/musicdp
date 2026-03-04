import 'package:flutter/material.dart';

class BottomStatusBar extends StatelessWidget {
  final String text;

  const BottomStatusBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      color: const Color.fromARGB(255, 10, 61, 36),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 12,
        ),
      ),
    );
  }
}