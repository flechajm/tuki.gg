import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/framework/extensions/context/context_extensions.dart';
import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/theme/theme_manager.dart';
import '../../../core/framework/util/app_settings.dart';
import '../../../core/framework/util/general_navigator.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/usecases/deal_info/params/params_deal.dart';
import '../common/simple_button/simple_button.dart';
import '../common/simple_check/simple_check.dart';
import '../common/simple_dropdown/simlpe_dropdown.dart';
import '../common/simple_scroll/simple_scroll.dart';
import '../common/text_link/text_link.dart';

typedef ApplyFilterCallback = void Function(ParamsDeal params);

class SearchDialog extends StatefulWidget {
  final String gameTitle;
  final ApplyFilterCallback onApplyFilter;
  final ParamsDeal params;
  final VoidCallback onCancel;

  const SearchDialog({
    super.key,
    required this.gameTitle,
    required this.onApplyFilter,
    required this.params,
    required this.onCancel,
  });

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  late ParamsDeal _paramsDeal;
  late List<Store> _stores;
  late String _sortByDirection;
  late Map<String, bool> _storesFilter;

  int _stackIndex = 0;

  @override
  void initState() {
    _paramsDeal = widget.params;
    _paramsDeal.gameTitle = widget.gameTitle;
    _sortByDirection = _paramsDeal.desc ? "desc" : "asc";
    _storesFilter = Map.from(AppSettings.storesFilter!);
    _stores = AppSettings.stores!.where((store) => store.isActive).toList();
    _stores.sort((a, b) => (_storesFilter[a.id.toString()]! ? 0 : 1).compareTo(_storesFilter[b.id.toString()]! ? 0 : 1));

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
      content: SizedBox(
        height: context.adjustHeight(dividedBy: 1.5),
        child: SimpleScroll(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stackIndex == 0
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStoresSelected(),
                        _buildSlider(
                          text: Localization.xSearch.xPriceRange.title,
                          subText: _getPriceRangeString(),
                          child: RangeSlider(
                            values: _paramsDeal.priceRange,
                            min: 0,
                            max: 50,
                            divisions: 10,
                            onChanged: (value) {
                              setState(() {
                                _paramsDeal.priceRange = RangeValues(value.start.roundToDouble(), value.end.roundToDouble());
                              });
                            },
                          ),
                        ),
                        _buildSlider(
                          text: Localization.xSearch.xSteamRating.title,
                          subText: _getSteamRatingString(),
                          child: Slider(
                            value: _paramsDeal.steamRating,
                            min: 0,
                            max: 95,
                            onChanged: (value) {
                              setState(() => _paramsDeal.steamRating = value);
                            },
                          ),
                        ),
                        _buildSlider(
                          text: Localization.xSearch.xMetacriticScore.title,
                          subText: _getMetacriticScoreString(),
                          child: Slider(
                            value: _paramsDeal.metacriticScore,
                            min: 0,
                            max: 95,
                            onChanged: (value) {
                              setState(() => _paramsDeal.metacriticScore = value);
                            },
                          ),
                        ),
                        _buildDropdown(
                          text: Localization.xSort.orderBy,
                          margin: const EdgeInsets.only(bottom: 10),
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
                          margin: const EdgeInsets.only(bottom: 10),
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
                        _buildDropdown(
                          text: Localization.xSort.pageSize,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: SimpleDropdown<int>(
                            items: AppSettings.pageSizeOptions,
                            value: _paramsDeal.pageSize.toString(),
                            itemsAlignment: Alignment.centerLeft,
                            dropdownAlignment: Alignment.centerLeft,
                            onChanged: (value) async {
                              if (value != _paramsDeal.pageSize.toString()) {
                                setState(() {
                                  _paramsDeal.pageSize = int.parse(value!);
                                });
                              }
                            },
                          ),
                        ),
                        SimpleCheck(
                          text: Localization.xSearch.aaaGame,
                          value: _paramsDeal.aaa,
                          width: 140,
                          onChanged: (value) {
                            setState(() => _paramsDeal.aaa = value!);
                          },
                        ),
                        SimpleCheck(
                          text: Localization.xSearch.onSale,
                          value: _paramsDeal.onSale,
                          width: 140,
                          onChanged: (value) {
                            setState(() => _paramsDeal.onSale = value!);
                          },
                        ),
                      ],
                    )
                  : _buildStoresList()
            ],
          ),
        ),
      ),
      actions: [
        SimpleButton(
          width: 50,
          tooltip: Localization.xSearch.tooltipResetFilter,
          leadingcon: Icon(
            FontAwesomeIcons.arrowsRotate,
            size: 18,
            color: ThemeManager.kSecondaryColor,
          ),
          style: SimpleButonStyle.secondary,
          onTap: () {
            setState(
              () {
                _setStoresSelected(true);
                _paramsDeal = ParamsDeal(
                  sortBy: AppSettings.sortByOptionSelected,
                  desc: AppSettings.sortIsDescending,
                );
              },
            );
          },
        ),
        SimpleButton(
          text: Localization.xCommon.cancel,
          style: SimpleButonStyle.secondary,
          onTap: widget.onCancel,
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
      AppSettings.setStartPriceRangeFilter(_paramsDeal.priceRange.start),
      AppSettings.setEndPriceRangeFilter(_paramsDeal.priceRange.end),
      AppSettings.setMetacriticScoreFilter(_paramsDeal.metacriticScore),
      AppSettings.setSteamRatingFilter(_paramsDeal.steamRating),
      AppSettings.setSortByOption(_paramsDeal.sortBy),
      AppSettings.setSortByDirection(_sortByDirection),
      AppSettings.setPageSize(_paramsDeal.pageSize),
      AppSettings.setIsAAAGameFilter(_paramsDeal.aaa),
      AppSettings.setIsOnSaleFilter(_paramsDeal.onSale),
      AppSettings.setStoresFilter(_storesFilter),
    ];

    await Future.wait(futures);

    setState(() {
      _paramsDeal.pageNumber = 0;
      _paramsDeal.storeIds = AppSettings.getJoinedStoresId();
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
            Localization.xSearch.popupTitle,
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
            FontAwesomeIcons.filter,
            color: ThemeManager.kSecondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String text,
    required Widget child,
    EdgeInsets? margin,
  }) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(bottom: 20),
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

  Widget _buildSlider({
    required String text,
    required String subText,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
              Text(
                subText,
                style: TextStyle(
                  fontFamily: ThemeManager.kSecondaryFont,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: child,
          ),
        ],
      ),
    );
  }

  Padding _buildStoresSelected() {
    int cantSelected = _storesFilter.entries.where((store) => store.value).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Localization.xSearch.xStores.title,
            style: TextStyle(
              fontFamily: ThemeManager.kSecondaryFont,
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20),
            child: TextLink(
              cantSelected == _storesFilter.length
                  ? Localization.xSearch.xStores.selectAll
                  : cantSelected > 1
                      ? Localization.xSearch.xStores.multiSelected(quantity: cantSelected)
                      : cantSelected == 1
                          ? Localization.xSearch.xStores.oneSelected
                          : Localization.xSearch.xStores.selectNone,
              textDecorationStyle: TextDecorationStyle.dotted,
              onTap: () => setState(() => _stackIndex = 1),
              style: TextStyle(
                fontSize: 18,
                color: ThemeManager.kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoresList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.translate(
              offset: const Offset(-10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _stackIndex = 0),
                    iconSize: 14,
                    splashRadius: 16,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    splashColor: ThemeManager.kSecondaryColor90,
                    highlightColor: ThemeManager.kSecondaryColor40,
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: ThemeManager.kSecondaryColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    Localization.xSearch.xStores.title.replaceAll(":", ""),
                    style: TextStyle(
                      fontFamily: ThemeManager.kSecondaryFont,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextLink(
                    Localization.xSearch.xStores.selectAll,
                    textDecorationStyle: TextDecorationStyle.dotted,
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeManager.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () => setState(() {
                      _setStoresSelected(true);
                    }),
                  ),
                  const Text(
                    " - ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextLink(
                    Localization.xSearch.xStores.selectNone,
                    textDecorationStyle: TextDecorationStyle.dotted,
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeManager.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () => setState(() {
                      _setStoresSelected(false);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.adjustHeight(dividedBy: 1.7),
          child: SimpleScroll(
            child: SimpleScroll(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ..._stores.map((store) {
                    bool isSelected = _storesFilter[store.id.toString()]!;

                    return ChoiceChip(
                      selected: isSelected,
                      backgroundColor: ThemeManager.kPrimaryColor,
                      selectedColor: ThemeManager.kPrimaryColor,
                      labelPadding: const EdgeInsets.only(left: 0),
                      avatar: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        child: Icon(
                          isSelected ? FontAwesomeIcons.solidCircleCheck : FontAwesomeIcons.solidCircleXmark,
                          size: 14,
                          color: isSelected ? Colors.greenAccent[700] : Colors.grey[400],
                        ),
                      ),
                      onSelected: (value) {
                        setState(() {
                          _storesFilter[store.id.toString()] = !isSelected;
                        });
                      },
                      label: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: CachedNetworkImage(
                              fadeInDuration: const Duration(milliseconds: 100),
                              imageUrl: store.iconUrl,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            store.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _setStoresSelected(bool selected) {
    _storesFilter.forEach((key, value) {
      _storesFilter[key] = selected;
    });
  }

  String _getPriceRangeString() {
    String minPrice = "\$${_paramsDeal.priceRange.start.toStringAsFixed(0)}";
    String maxPrice = "\$${_paramsDeal.priceRange.end.toStringAsFixed(0)}";
    String maxRangePrice = _paramsDeal.priceRange.end == 50 ? "+" : "";
    bool itsFree = _paramsDeal.priceRange.start == 0 && _paramsDeal.priceRange.end == 0;

    return itsFree ? Localization.xSearch.xPriceRange.free : "$minPrice - $maxPrice $maxRangePrice";
  }

  String _getSteamRatingString() {
    String rating = _paramsDeal.steamRating == 0 ? Localization.xSearch.xSteamRating.any : "${_paramsDeal.steamRating.toStringAsFixed(0)}%";
    String maxRating = _paramsDeal.steamRating == 95 ? "+" : "";

    return "$rating $maxRating";
  }

  String _getMetacriticScoreString() {
    String rating = _paramsDeal.metacriticScore == 0 ? Localization.xSearch.xMetacriticScore.any : _paramsDeal.metacriticScore.toStringAsFixed(0);
    String maxRating = _paramsDeal.metacriticScore == 95 ? "+" : "";

    return "$rating $maxRating";
  }
}
