import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/steam_achievement.dart';
import '../steam_achievement_highlighted/steam_achievement_highlighted_model.dart';

part 'steam_achievement_model.g.dart';

@JsonSerializable(createToJson: false)
class SteamAchievementModel extends SteamAchievement {
  const SteamAchievementModel({
    required super.total,
    required List<SteamAchievementHighlightedModel> highlighted,
  }) : super(highlighted: highlighted);

  @override
  List<SteamAchievementHighlightedModel> get highlighted => super.highlighted as List<SteamAchievementHighlightedModel>;

  factory SteamAchievementModel.fromJson(Map<String, dynamic> json) {
    return _$SteamAchievementModelFromJson(json);
  }
}
