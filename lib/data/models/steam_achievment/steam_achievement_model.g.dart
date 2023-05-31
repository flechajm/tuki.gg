// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steam_achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SteamAchievementModel _$SteamAchievementModelFromJson(
        Map<String, dynamic> json) =>
    SteamAchievementModel(
      total: json['total'] as int,
      highlighted: (json['highlighted'] as List<dynamic>)
          .map((e) => SteamAchievementHighlightedModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
