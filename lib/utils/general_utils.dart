import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

Widget getMarquee(String text, {TextStyle? style, double height = 24}) {
  return SizedBox(
    height: height,
    child: Center(
      child: Marquee(
        text: text,
        style: style ?? const TextStyle(
          fontSize: 14,
          color: Colors.greenAccent,
        ),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 40.0,
        velocity: 30.0,
        pauseAfterRound: const Duration(seconds: 1),
        startPadding: 10.0,
        accelerationDuration: const Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    ),
  );
}