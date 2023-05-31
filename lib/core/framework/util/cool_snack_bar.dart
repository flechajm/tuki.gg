import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CoolSnackBar {
  final BuildContext _context;

  CoolSnackBar._(this._context);

  static CoolSnackBar of(BuildContext context) => CoolSnackBar._(context);

  void success(text, {Duration? duration, EdgeInsets? margin}) {
    _show(text: text, icon: FontAwesomeIcons.circleCheck, backgroundColor: Colors.green[600], duration: duration, margin: margin);
  }

  void info(text, {Duration? duration, EdgeInsets? margin}) {
    _show(
      text: text,
      icon: FontAwesomeIcons.circleInfo,
      backgroundColor: Colors.blue[600],
      duration: duration,
      margin: margin,
    );
  }

  void warning(text, {Duration? duration, EdgeInsets? margin}) {
    _show(text: text, icon: FontAwesomeIcons.triangleExclamation, backgroundColor: Colors.yellow[800], duration: duration, margin: margin);
  }

  void error(text, {Duration? duration, EdgeInsets? margin}) {
    _show(text: text, icon: Icons.cancel_rounded, backgroundColor: Colors.red[600], duration: duration, margin: margin);
  }

  void custom({
    required String text,
    Color? backgroundColor,
    IconData? icon,
    Duration? duration,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    DismissDirection? dismissDirection,
    MainAxisAlignment? mainAxisAlignment,
    EdgeInsets? padding,
  }) {
    _show(
      text: text,
      backgroundColor: backgroundColor,
      icon: icon,
      duration: duration,
      margin: margin,
      borderRadius: borderRadius,
      dismissDirection: dismissDirection,
      mainAxisAlignment: mainAxisAlignment,
      padding: padding,
    );
  }

  void _show({
    required String text,
    Color? backgroundColor,
    IconData? icon,
    Duration? duration,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    DismissDirection? dismissDirection,
    MainAxisAlignment? mainAxisAlignment,
    EdgeInsets? padding,
  }) {
    final snackBar = SnackBar(
      elevation: 3,
      backgroundColor: backgroundColor,
      padding: EdgeInsets.zero,
      margin: margin,
      behavior: SnackBarBehavior.floating,
      dismissDirection: dismissDirection ?? DismissDirection.endToStart,
      shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(5)),
      duration: duration ?? const Duration(seconds: 3),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: IntrinsicHeight(
        child: Stack(
          children: [
            if (borderRadius == null)
              Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  color: Colors.white30,
                ),
                padding: const EdgeInsets.only(right: 20),
                width: 6,
              ),
            Padding(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: Row(
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(icon, color: Colors.white70),
                    ),
                  Flexible(child: Text(text)),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(_context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
