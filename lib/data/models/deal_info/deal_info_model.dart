import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/deal_info.dart';

part 'deal_info_model.g.dart';

@JsonSerializable(createToJson: false)
class DealInfoModel extends DealInfo {
  @override
  @JsonKey(fromJson: toInt)
  int get storeID => super.storeID;

  @override
  @JsonKey(fromJson: toInt)
  int get gameID => super.gameID;

  @override
  @JsonKey(fromJson: toIntNullable)
  int? get steamAppID => super.steamAppID;

  @override
  @JsonKey(fromJson: toDouble)
  double get salePrice => super.salePrice;

  @override
  @JsonKey(fromJson: toDouble)
  double get normalPrice => super.normalPrice;

  @override
  @JsonKey(fromJson: toDouble)
  double get savings => super.savings;

  @override
  @JsonKey(fromJson: toDoubleNullable)
  double? get steamRatingPercent => super.steamRatingPercent;

  @override
  @JsonKey(fromJson: toIntNullable)
  int? get steamRatingCount => super.steamRatingCount;

  @override
  @JsonKey(fromJson: toIntNullable)
  int? get metacriticScore => super.metacriticScore;

  DealInfoModel({
    required super.internalName,
    required super.title,
    required super.dealID,
    required super.storeID,
    required super.gameID,
    required super.salePrice,
    required super.normalPrice,
    required super.savings,
    required super.isOnSale,
    super.steamAppID,
    super.steamRatingText,
    super.steamRatingPercent,
    super.steamRatingCount,
    super.metacriticLink,
    super.metacriticScore,
    super.releaseDate,
    required super.thumb,
  }) : super(
          dealUrl: "https://www.cheapshark.com/redirect?dealID=$dealID",
          coverImage: steamAppID != null
              ? "https://cdn.cloudflare.steamstatic.com/steam/apps/$steamAppID/header.jpg?t=${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch}"
              : thumb,
        );

  factory DealInfoModel.fromJson(Map<String, dynamic> json) {
    return _$DealInfoModelFromJson(json);
  }
}

int toInt(String value) => int.parse(value);
int? toIntNullable(String? value) => value != null ? int.parse(value) : null;
double toDouble(String value) => double.parse(value);
double? toDoubleNullable(String? value) => value != null ? double.parse(value) : null;
