// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealInfoModel _$DealInfoModelFromJson(Map<String, dynamic> json) =>
    DealInfoModel(
      internalName: json['internalName'] as String,
      title: json['title'] as String,
      dealID: json['dealID'] as String,
      storeID: toInt(json['storeID'] as String),
      gameID: toInt(json['gameID'] as String),
      salePrice: toDouble(json['salePrice'] as String),
      normalPrice: toDouble(json['normalPrice'] as String),
      savings: toDouble(json['savings'] as String),
      isOnSale: json['isOnSale'] as String,
      steamAppID: toIntNullable(json['steamAppID'] as String?),
      steamRatingText: json['steamRatingText'] as String?,
      steamRatingPercent:
          toDoubleNullable(json['steamRatingPercent'] as String?),
      steamRatingCount: toIntNullable(json['steamRatingCount'] as String?),
      metacriticLink: json['metacriticLink'] as String?,
      metacriticScore: toIntNullable(json['metacriticScore'] as String?),
      releaseDate: json['releaseDate'] as int?,
      thumb: json['thumb'] as String,
    );
