abstract class Store {
  final int id;
  final String name;
  final bool isActive;
  final String iconUrl;
  final String bannerUrl;

  const Store({
    required this.id,
    required this.name,
    required this.isActive,
    required this.iconUrl,
    required this.bannerUrl,
  });
}
