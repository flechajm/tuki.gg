abstract class TukiNotification {
  final String id;
  final String gameName;
  final int gameId;
  final String dealId;
  final String dealUrl;
  final int storeId;
  final double price;
  final String imageUrl;
  final DateTime date;

  const TukiNotification({
    required this.id,
    required this.gameName,
    required this.gameId,
    required this.dealId,
    required this.dealUrl,
    required this.storeId,
    required this.price,
    required this.imageUrl,
    required this.date,
  });
}
