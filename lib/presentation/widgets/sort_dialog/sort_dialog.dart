import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/framework/extensions/context/context_extensions.dart';
import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/theme/theme_manager.dart';
import '../../../core/framework/util/app_settings.dart';
import '../../../core/framework/util/general_navigator.dart';
import '../../../domain/usecases/deal_info/params/params_deal.dart';
import '../common/simple_button/simple_button.dart';
import '../common/simple_dropdown/simlpe_dropdown.dart';
import '../search_dialog/search_dialog.dart';

class SortDialog extends StatefulWidget {
  final ParamsDeal params;
  final ApplyFilterCallback onApplyFilter;

  const SortDialog({
    super.key,
    required this.params,
    required this.onApplyFilter,
  });

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  late ParamsDeal _paramsDeal;
  late String _sortByDirection;

  @override
  void initState() {
    _paramsDeal = widget.params;
    _sortByDirection = _paramsDeal.desc ? "desc" : "asc";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: ThemeManager.kBackgroundColor,
      titleTextStyle: TextStyle(
        fontFamily: ThemeManager.kPrimaryFont,
        color: ThemeManager.kSecondaryColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      title: _buildTitle(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdown(
            text: Localization.xSort.orderBy,
            child: SimpleDropdown(
              width: 200,
              items: AppSettings.sortByOptions,
              value: _paramsDeal.sortBy,
              itemsAlignment: Alignment.centerLeft,
              dropdownAlignment: Alignment.centerLeft,
              onChanged: (value) async {
                if (value != _paramsDeal.sortBy) {
                  setState(() => _paramsDeal.sortBy = value!);
                }
              },
            ),
          ),
          _buildDropdown(
            text: Localization.xSort.sortDirection,
            child: SimpleDropdown(
              items: AppSettings.sortByDirections,
              value: _sortByDirection,
              itemsAlignment: Alignment.centerLeft,
              dropdownAlignment: Alignment.centerLeft,
              onChanged: (value) async {
                if (value != _sortByDirection) {
                  setState(() {
                    _sortByDirection = value!;
                    _paramsDeal.desc = _sortByDirection == "desc";
                  });
                }
              },
            ),
          ),
        ],
      ),
      actions: [
        SimpleButton(
          text: Localization.xCommon.cancel,
          style: SimpleButonStyle.secondary,
          onTap: () => GeneralNavigator.pop(),
        ),
        SimpleButton(
          text: Localization.xCommon.apply,
          onTap: () async {
            await _apply();
            GeneralNavigator.pop();
            widget.onApplyFilter(_paramsDeal);
          },
        ),
      ],
    );
  }

  Future<void> _apply() async {
    List<Future<void>> futures = [
      AppSettings.setSortByOption(_paramsDeal.sortBy),
      AppSettings.setSortByDirection(_sortByDirection),
    ];

    await Future.wait(futures);

    setState(() {
      _paramsDeal.pageNumber = 0;
      _paramsDeal.sortBy = _paramsDeal.sortBy;
      _paramsDeal.desc = AppSettings.sortIsDescending;
    });
  }

  SizedBox _buildTitle(BuildContext context) {
    return SizedBox(
      width: context.adjustWidth(dividedBy: 1.2),
      child: Row(
        children: [
          Text(
            Localization.xSort.popupTitle,
            style: TextStyle(
              fontFamily: ThemeManager.kSecondaryFont,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Divider(
              color: ThemeManager.kSecondaryColor,
              indent: 10,
              endIndent: 10,
            ),
          ),
          Icon(
            FontAwesomeIcons.arrowDownWideShort,
            color: ThemeManager.kSecondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String text,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
            child: child,
          ),
        ],
      ),
    );
  }
}
