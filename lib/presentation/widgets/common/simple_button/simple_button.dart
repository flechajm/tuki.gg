import 'package:flutter/material.dart';

import '../../../../core/framework/theme/theme_manager.dart';

enum SimpleButonStyle {
  primary,
  secondary,
  tuki,
}

class SimpleButton extends StatelessWidget {
  final String? text;
  final Icon? leadingcon;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final SimpleButonStyle style;
  final String? tooltip;

  const SimpleButton({
    super.key,
    this.text,
    this.leadingcon,
    required this.onTap,
    this.width,
    this.height,
    this.margin,
    this.style = SimpleButonStyle.primary,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        height: height ?? 45,
        width: width,
        child: Tooltip(
          verticalOffset: -70,
          message: tooltip ?? "",
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              backgroundColor: _getColor(),
              side: BorderSide(color: _getBorderColor()),
              foregroundColor: _getForegroundColor(),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leadingcon != null) leadingcon!,
                  if (text != null)
                    Text(
                      text!,
                      style: _getButtonStyle(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color? _getForegroundColor() {
    switch (style) {
      case SimpleButonStyle.primary:
        return null;
      case SimpleButonStyle.tuki:
        return ThemeManager.kSecondaryColor.withOpacity(0.8);
      default:
        return const Color(0xFF3B2F44);
    }
  }

  Color _getBorderColor() {
    switch (style) {
      case SimpleButonStyle.primary:
        return Colors.transparent;
      case SimpleButonStyle.tuki:
        return ThemeManager.kSecondaryColor.withOpacity(0.8);
      default:
        return const Color(0xFF2A2033);
    }
  }

  Color _getColor() {
    switch (style) {
      case SimpleButonStyle.primary:
        return ThemeManager.kPrimaryColor;
      case SimpleButonStyle.tuki:
        return ThemeManager.kSecondaryColor.withOpacity(0.8);
      default:
        return const Color(0xFF1C1522);
    }
  }

  TextStyle _getButtonStyle() {
    switch (style) {
      case SimpleButonStyle.primary:
        return _getTextStyleDefault();
      case SimpleButonStyle.tuki:
        return _getTextStyleTukiButton();
      default:
        return _getTextStyleDefault();
    }
  }

  TextStyle _getTextStyleTukiButton() {
    return TextStyle(
      fontFamily: ThemeManager.kPrimaryFont,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: -1,
      color: Colors.white,
    );
  }

  TextStyle _getTextStyleDefault() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }
}
