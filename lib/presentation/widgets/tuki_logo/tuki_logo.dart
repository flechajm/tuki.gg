import 'package:flutter/material.dart';

import '../../../core/framework/theme/theme_manager.dart';
import '../gradient_text/gradient_text.dart';

class TukiLogo extends StatelessWidget {
  final double size;

  const TukiLogo({
    Key? key,
    this.size = 84,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "tuki",
          style: TextStyle(
            fontFamily: 'Catamaran',
            fontSize: size,
            color: ThemeManager.kPrimaryColor,
            letterSpacing: -2,
            fontWeight: FontWeight.bold,
          ),
        ),
        GradientText(
          ".gg",
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ThemeManager.kSecondaryColor,
              ThemeManager.kSecondaryLightColor,
            ],
          ),
          style: TextStyle(
            fontFamily: 'Catamaran',
            fontSize: size,
            letterSpacing: -2,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
