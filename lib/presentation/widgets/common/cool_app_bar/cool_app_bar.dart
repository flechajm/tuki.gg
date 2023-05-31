import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/framework/localization/localization.dart';
import '../../../../core/framework/theme/theme_manager.dart';
import '../../../../core/framework/util/general_navigator.dart';
import '../../../../core/framework/util/notification_handler.dart';
import '../../../../core/framework/util/util.dart';
import '../../../../domain/usecases/deal_info/params/params_deal.dart';
import '../../../screens/notifications/notifications_screen.dart';
import '../../../screens/settings/settings_screen.dart';
import '../../search_dialog/search_dialog.dart';
import '../../tuki_logo/tuki_logo.dart';

class CoolAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  final bool showBackButton;
  final bool showActionButtons;
  final bool searchMode;
  final VoidCallback? onTapBack;
  final ApplyFilterCallback? filterFunction;
  final ParamsDeal? filterParams;

  const CoolAppBar({
    super.key,
    this.title,
    this.showLogo = true,
    this.showBackButton = false,
    this.showActionButtons = true,
    this.searchMode = false,
    this.onTapBack,
    this.filterFunction,
    this.filterParams,
  });

  @override
  State<CoolAppBar> createState() => _CoolAppBarState();

  @override
  Size get preferredSize => Util.sizeAppBar;
}

class _CoolAppBarState extends State<CoolAppBar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodeSearch = FocusNode();
  final TextEditingController _textSearchController = TextEditingController();

  late ParamsDeal? _filterParams;
  late bool _searchMode;

  @override
  void initState() {
    _filterParams = widget.filterParams;
    _searchMode = widget.searchMode;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CoolAppBar oldWidget) {
    if (oldWidget.filterParams != widget.filterParams || oldWidget.searchMode == widget.searchMode) {
      _filterParams = widget.filterParams;
      _searchMode = widget.searchMode;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: !widget.showLogo,
      title: !_searchMode && widget.showLogo
          ? const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: TukiLogo(size: 42),
              ),
            )
          : widget.title != null
              ? Text(widget.title!)
              : null,
      automaticallyImplyLeading: false,
      leadingWidth: _searchMode ? double.infinity : null,
      leading: _searchMode
          ? _buildSearchBar()
          : widget.showBackButton
              ? IconButton(
                  padding: const EdgeInsets.only(bottom: 2),
                  onPressed: widget.onTapBack ?? () => GeneralNavigator.pop(),
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: ThemeManager.kPrimaryColor,
                  ),
                  tooltip: Localization.xCommon.back,
                  splashRadius: 22,
                )
              : null,
      actions: widget.showActionButtons && !_searchMode
          ? [
              _buildSearchButton(),
              _buildFilterButton(),
              _buildNotificationButton(),
              _buildSettingsButton(),
            ]
          : null,
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Flexible(
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              shadowColor: ThemeManager.kSecondaryColor40,
              borderRadius: BorderRadius.circular(18),
              child: Form(
                key: _formKey,
                child: TextField(
                  controller: _textSearchController,
                  focusNode: _focusNodeSearch,
                  autocorrect: false,
                  maxLines: 1,
                  minLines: 1,
                  cursorHeight: 30,
                  decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 18,
                          constraints: const BoxConstraints(maxWidth: 38, maxHeight: 38),
                          splashRadius: 18,
                          onPressed: () => _textSearchController.clear(),
                          icon: Icon(
                            FontAwesomeIcons.eraser,
                            size: 18,
                            color: ThemeManager.kPrimaryColor,
                          ),
                          tooltip: Localization.xSearch.tooltipErase,
                        ),
                        IconButton(
                          iconSize: 18,
                          constraints: const BoxConstraints(maxWidth: 38, maxHeight: 38),
                          splashRadius: 18,
                          onPressed: () {
                            setState(() {
                              _searchMode = false;
                            });
                          },
                          icon: const Icon(
                            FontAwesomeIcons.x,
                            size: 18,
                            color: Colors.white12,
                          ),
                          tooltip: Localization.xSearch.tooltipClose,
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 10),
                    filled: true,
                    hintText: Localization.xSearch.hint,
                    hintStyle: TextStyle(
                      color: Colors.white10,
                      fontFamily: ThemeManager.kPrimaryFont,
                    ),
                    focusColor: ThemeManager.kPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeManager.kPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeManager.kPrimaryColor90, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: ThemeManager.kPrimaryFont,
                    fontSize: 18,
                    color: ThemeManager.kSecondaryColor,
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      _filterParams!.gameTitle = value;
                      _filterParams!.pageNumber = 0;
                    });
                    widget.filterFunction!(_filterParams!);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return IconButton(
      visualDensity: VisualDensity.comfortable,
      padding: const EdgeInsets.only(bottom: 2),
      onPressed: () {
        setState(() {
          _searchMode = true;
          _focusNodeSearch.requestFocus();
        });
      },
      icon: const Icon(
        FontAwesomeIcons.magnifyingGlass,
        color: Colors.white,
      ),
      tooltip: Localization.xSearch.title,
      splashRadius: 22,
    );
  }

  Widget _buildFilterButton() {
    return IconButton(
      visualDensity: VisualDensity.comfortable,
      padding: const EdgeInsets.only(bottom: 2),
      onPressed: () {
        _focusNodeSearch.unfocus();
        Future.delayed(
          Duration(milliseconds: _focusNodeSearch.hasFocus ? 300 : 0),
          () {
            showDialog(
              context: context,
              barrierColor: Colors.black87,
              barrierDismissible: false,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async {
                    return Future.value(true).whenComplete(() => _focusNodeSearch.requestFocus());
                  },
                  child: SearchDialog(
                    onApplyFilter: widget.filterFunction!,
                    gameTitle: _textSearchController.text,
                    params: _filterParams!,
                    onCancel: () {
                      GeneralNavigator.pop();
                      _focusNodeSearch.requestFocus();
                    },
                  ),
                );
              },
            );
          },
        );
      },
      icon: const Icon(
        FontAwesomeIcons.filter,
        color: Colors.white,
      ),
      tooltip: Localization.xSearch.tooltipFilter,
      splashRadius: 22,
    );
  }

  Widget _buildNotificationButton() {
    return ValueListenableBuilder(
      valueListenable: NotificationHandler.hasNewNotifications,
      builder: (BuildContext context, value, Widget? child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              visualDensity: VisualDensity.comfortable,
              padding: const EdgeInsets.only(bottom: 2),
              onPressed: () => GeneralNavigator.push(const NotificationsScreen()),
              icon: const Icon(
                FontAwesomeIcons.solidBell,
                color: Colors.white,
              ),
              tooltip: Localization.xSort.tooltip,
              splashRadius: 22,
            ),
            if (value)
              Positioned(
                right: 13,
                top: 15,
                child: Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(
                      color: ThemeManager.kBackgroundColor,
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: IconButton(
        visualDensity: VisualDensity.comfortable,
        padding: const EdgeInsets.only(bottom: 2),
        onPressed: () => GeneralNavigator.push(const SettingsScreen()), //,
        icon: const Icon(
          FontAwesomeIcons.gear,
          color: Colors.white,
        ),
        tooltip: Localization.xSettings.title,
        splashRadius: 22,
      ),
    );
  }
}
