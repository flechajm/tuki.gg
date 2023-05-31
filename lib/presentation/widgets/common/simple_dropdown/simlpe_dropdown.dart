import 'package:flutter/material.dart';

import '../../../../core/framework/theme/theme_manager.dart';
import '../text_link/text_link.dart';

class SimpleDropdown<T> extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final Map<String, T> items;
  final String value;
  final double? width;
  final Alignment? itemsAlignment;
  final Alignment? dropdownAlignment;

  const SimpleDropdown({
    super.key,
    required this.onChanged,
    required this.items,
    required this.value,
    this.width,
    this.itemsAlignment,
    this.dropdownAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: ThemeManager.getTheme(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: DropdownButton(
            borderRadius: BorderRadius.circular(6),
            iconSize: 0,
            underline: const SizedBox.shrink(),
            dropdownColor: Colors.black,
            value: value,
            selectedItemBuilder: (context) {
              return items.entries.map((e) {
                return DropdownMenuItem(
                  alignment: dropdownAlignment ?? Alignment.centerRight,
                  value: e.key,
                  child: Container(
                    width: width,
                    alignment: dropdownAlignment,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextLink(
                        items[value]!.toString(),
                        textDecorationStyle: TextDecorationStyle.dotted,
                        isDropdownMenuItem: true,
                        style: _getOptionTextStyle(),
                      ),
                    ),
                  ),
                );
              }).toList();
            },
            items: items.entries.map((e) {
              return DropdownMenuItem(
                alignment: itemsAlignment ?? Alignment.center,
                value: e.key,
                child: TextLink(
                  e.value.toString(),
                  textDecorationStyle: TextDecorationStyle.dotted,
                  isDropdownMenuItem: true,
                  style: _getOptionTextStyle(),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  TextStyle _getOptionTextStyle() {
    return TextStyle(
      fontSize: 18,
      color: ThemeManager.kPrimaryColor,
      fontWeight: FontWeight.bold,
    );
  }
}
