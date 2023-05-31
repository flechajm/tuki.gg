import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/steam_achievement_highlighted.dart';

part 'steam_achievement_highlighted_model.g.dart';

@JsonSerializable(createToJson: false)
class SteamAchievementHighlightedModel extends SteamAchievementHighlighted {
  const SteamAchievementHighlightedModel({
    required super.name,
    required super.path,
  });

  factory SteamAchievementHighlightedModel.fromJson(Map<String, dynamic> json) {
    return _$SteamAchievementHighlightedModelFromJson(json);
  }
}
