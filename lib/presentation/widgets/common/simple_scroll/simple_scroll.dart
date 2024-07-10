import 'package:flutter/material.dart';

class SimpleScroll extends StatelessWidget {
  final Widget child;
  final Axis scrollDirection;
  final ScrollController? controller;
  final bool onlyDisableGlow;

  const SimpleScroll({
    super.key,
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.onlyDisableGlow = false,
  }) : assert(onlyDisableGlow && controller == null || !onlyDisableGlow);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: onlyDisableGlow
          ? child
          : SingleChildScrollView(
              controller: controller,
              scrollDirection: scrollDirection,
              physics: const ScrollPhysics(),
              child: child,
            ),
    );
  }
}
