import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class RowInfo extends StatelessWidget {
  final String text;
  final String value;

  const RowInfo({
    super.key,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: TextScroll(
                value,
                delayBefore: const Duration(seconds: 2),
                pauseBetween: const Duration(seconds: 5),
                fadeBorderSide: FadeBorderSide.right,
                fadedBorder: true,
                numberOfReps: 2,
                velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                intervalSpaces: 25,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.lightBlue[300]!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
