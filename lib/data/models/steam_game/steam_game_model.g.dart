// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steam_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SteamGameModel _$SteamGameModelFromJson(Map<String, dynamic> json) =>
    SteamGameModel(
      appId: json['steam_appid'] as int,
      name: json['name'] as String,
      description: json['short_description'] as String,
      website: json['website'] as String?,
      developers: (json['developers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publishers: (json['publishers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categories: toList(json['categories'] as List?),
      genres: toList(json['genres'] as List?),
      achievements: json['achievements'] == null
          ? null
          : SteamAchievementModel.fromJson(
              json['achievements'] as Map<String, dynamic>),
      salePrice: readSalePrice(json, 'salePrice') as String?,
      normalPrice: readNormalPrice(json, 'normalPrice') as String?,
      backgroundImage: json['background_raw'] as String,
    );
