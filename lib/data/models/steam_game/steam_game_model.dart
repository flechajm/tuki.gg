import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/steam_game.dart';
import '../steam_achievment/steam_achievement_model.dart';

part 'steam_game_model.g.dart';

@JsonSerializable(createToJson: false)
class SteamGameModel extends SteamGame {
  @override
  @JsonKey(name: "steam_appid")
  int get appId => super.appId;

  @override
  @JsonKey(name: "short_description")
  String get description => super.description;

  @override
  @JsonKey(name: "background_raw")
  String get backgroundImage => super.backgroundImage;

  @override
  @JsonKey(fromJson: toList)
  List<String>? get categories => super.categories;

  @override
  @JsonKey(fromJson: toList)
  List<String>? get genres => super.genres;

  @override
  SteamAchievementModel? get achievements => super.achievements as SteamAchievementModel?;

  @override
  @JsonKey(readValue: readSalePrice)
  get salePrice => super.salePrice;

  @override
  @JsonKey(readValue: readNormalPrice)
  get normalPrice => super.normalPrice;

  SteamGameModel({
    required super.appId,
    required super.name,
    required super.description,
    super.website,
    super.developers,
    super.publishers,
    super.categories,
    super.genres,
    SteamAchievementModel? achievements,
    super.salePrice,
    super.normalPrice,
    required super.backgroundImage,
  }) : super(achievements: achievements);

  factory SteamGameModel.fromJson(Map<String, dynamic> json) {
    return _$SteamGameModelFromJson(json);
  }
}

Object? readNormalPrice(Map<dynamic, dynamic> json, String field) {
  if (json["price_overview"] != null) {
    return json['price_overview']['initial_formatted'];
  }

  return null;
}

Object? readSalePrice(Map<dynamic, dynamic> json, String field) {
  if (json["price_overview"] != null) {
    return json['price_overview']['final_formatted'];
  }

  return null;
}

List<String>? toList(List? map) {
  return map?.map<String>((e) => e["description"]).toList();
}
