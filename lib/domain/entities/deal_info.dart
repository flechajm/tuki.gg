abstract class DealInfo {
  final String internalName;
  final String title;
  final String dealID;
  final String dealUrl;
  final int storeID;
  final int gameID;
  final double salePrice;
  final double normalPrice;
  final double savings;
  final String isOnSale;
  final int? steamAppID;
  final String? steamRatingText;
  final double? steamRatingPercent;
  final int? steamRatingCount;
  final String? metacriticLink;
  final int? metacriticScore;
  final int? releaseDate;
  final String coverImage;
  final String thumb;

  DealInfo({
    required this.internalName,
    required this.title,
    required this.dealID,
    required this.dealUrl,
    required this.storeID,
    required this.gameID,
    required this.salePrice,
    required this.normalPrice,
    required this.savings,
    required this.isOnSale,
    this.steamAppID,
    this.steamRatingText,
    this.steamRatingPercent,
    this.steamRatingCount,
    this.metacriticLink,
    this.metacriticScore,
    this.releaseDate,
    required this.coverImage,
    required this.thumb,
  });
}
