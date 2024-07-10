import 'package:flutter/material.dart';

import '../../../../core/framework/theme/theme_manager.dart';

class TextLink extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final Color? activeColor;
  final bool? showTextDecoration;
  final TextDecorationStyle? textDecorationStyle;
  final VoidCallback? onTap;
  final bool isDropdownMenuItem;

  const TextLink(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.activeColor,
    this.showTextDecoration = true,
    this.textDecorationStyle = TextDecorationStyle.solid,
    this.onTap,
    this.isDropdownMenuItem = false,
  });

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  late Color _textColor;

  @override
  void initState() {
    super.initState();
    _textColor = widget.color ?? ThemeManager.kPrimaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTapDown: widget.isDropdownMenuItem
          ? null
          : (details) {
              setState(() {
                _textColor = widget.activeColor ?? ThemeManager.kPrimaryLightColor;
              });
            },
      onTapUp: widget.isDropdownMenuItem
          ? null
          : (details) {
              setState(() {
                _textColor = widget.color ?? ThemeManager.kPrimaryColor;
              });

              if (widget.onTap != null) widget.onTap!();
            },
      onTapCancel: widget.isDropdownMenuItem
          ? null
          : () {
              setState(() {
                _textColor = widget.color ?? ThemeManager.kPrimaryColor;
              });
            },
      child: Transform.translate(
        offset: const Offset(0, 3),
        child: Text(
          widget.text,
          style: _getStyleMerged(),
        ),
      ),
    );
  }

  TextStyle _getStyle() {
    return TextStyle(
      shadows: [
        Shadow(
          color: _textColor,
          offset: const Offset(0, -5),
        ),
      ],
      color: Colors.transparent,
      decoration: widget.showTextDecoration! ? TextDecoration.underline : TextDecoration.none,
      decorationColor: _textColor,
      decorationStyle: widget.textDecorationStyle ?? TextDecorationStyle.solid,
    );
  }

  TextStyle _getStyleMerged() {
    return widget.style != null ? widget.style!.merge(_getStyle()) : _getStyle();
  }
}
