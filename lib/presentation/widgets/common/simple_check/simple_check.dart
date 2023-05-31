import 'package:flutter/material.dart';

import '../../../../core/framework/theme/theme_manager.dart';

class SimpleCheck extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final double? width;

  const SimpleCheck({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: ThemeManager.kSecondaryFont,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 1),
              child: Checkbox(
                visualDensity: VisualDensity.compact,
                activeColor: ThemeManager.kPrimaryColor,
                splashRadius: 18,
                value: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
