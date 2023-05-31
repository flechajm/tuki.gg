import 'steam_achievement.dart';

abstract class SteamGame {
  final int appId;
  final String name;
  final String description;
  final String? website;
  final List<String>? developers;
  final List<String>? publishers;
  final List<String>? categories;
  final List<String>? genres;
  final SteamAchievement? achievements;
  final String? salePrice;
  final String? normalPrice;
  final String backgroundImage;

  SteamGame({
    required this.appId,
    required this.name,
    required this.description,
    this.website,
    this.developers,
    this.publishers,
    this.categories,
    this.genres,
    this.achievements,
    this.salePrice,
    this.normalPrice,
    required this.backgroundImage,
  });
}
