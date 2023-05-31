import 'package:flutter/material.dart';

class ParamsDeal {
  String? storeIds;
  int pageNumber;
  int pageSize;
  RangeValues priceRange;
  double metacriticScore;
  double steamRating;
  String gameTitle;
  bool aaa;
  bool onSale;
  String sortBy;
  bool desc;

  ParamsDeal({
    this.storeIds,
    this.pageNumber = 0,
    this.pageSize = 10,
    this.priceRange = const RangeValues(0, 50),
    this.metacriticScore = 0,
    this.steamRating = 0,
    this.gameTitle = "",
    this.aaa = false,
    this.onSale = false,
    this.sortBy = "",
    this.desc = false,
  });
}
