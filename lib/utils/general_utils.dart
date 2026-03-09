import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

//Widget getSimpleText(String? text, {TextStyle? style, int maxChars = 20}) {
Widget getMarquee(String? text, {TextStyle? style, int maxChars = 20}) {
  // Ensure maxChars is defined and has a default value
  final int charsLimit = maxChars;
  // Handle null or empty text
  final displayText = (text == null || text.isEmpty)
      ? 'Select a Source'
      : (text.length > charsLimit ? '${text.substring(0, charsLimit)}..' : text);
  return Text(
    displayText,
    style: style ?? const TextStyle(
      fontSize: 14,
      color: Colors.green,
    ),
    overflow: TextOverflow.ellipsis,
  );
}
/*
Widget getMarquee(String text, {TextStyle? style, double height = 24}) {
  return SizedBox(
    height: height,
    child: Center(
      child: Marquee(
        text:  text ?? '',
        style: style ?? const TextStyle(
          fontSize: 14,
          color: Colors.black87,
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
*/