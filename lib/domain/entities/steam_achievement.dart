import 'steam_achievement_highlighted.dart';

abstract class SteamAchievement {
  final int total;
  final List<SteamAchievementHighlighted> highlighted;

  const SteamAchievement({
    required this.total,
    required this.highlighted,
  });
}
