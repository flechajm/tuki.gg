import 'package:flutter/material.dart';

import '../../../../core/framework/extensions/context/context_extensions.dart';

class CenterCircleLoading extends StatelessWidget {
  final double heightDivider;
  final double? size;
  final EdgeInsets? margin;
  final double? value;
  final Color? color;
  final Color? backgroundColor;

  const CenterCircleLoading({
    super.key,
    this.heightDivider = 1.5,
    this.size,
    this.margin,
    this.value,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Center(
        child: SizedBox(
          height: size ?? context.height / heightDivider,
          width: size,
          child: Center(
            child: CircularProgressIndicator(
              color: color,
              backgroundColor: backgroundColor,
              value: value,
            ),
          ),
        ),
      ),
    );
  }
}
