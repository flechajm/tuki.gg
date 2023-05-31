import 'package:flutter/material.dart';

import '../../../../core/framework/theme/theme_manager.dart';
import 'option.dart';

export 'option.dart';

class HeaderTitle extends StatelessWidget {
  final String text;
  final List<Option> options;
  final EdgeInsets? margin;

  const HeaderTitle({
    super.key,
    required this.text,
    required this.options,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: ThemeManager.kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          ...options,
        ],
      ),
    );
  }
}
