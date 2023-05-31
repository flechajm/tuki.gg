import 'dart:convert';
import 'dart:io';

import '../../../domain/entities/store.dart';
import '../localization/localization.dart';
import 'util_preferences.dart';

class AppSettings {
  static final AppSettings _singleton = AppSettings._internal();
  factory AppSettings() {
    return _singleton;
  }
  AppSettings._internal();

  // Settings options

  static late String _appLang;
  static String get appLang => _appLang;

  static late String _gameDataLang;
  static String get gameDataLang => _gameDataLang;

  static late String _currency;
  static String get currency => _currency;

  static late bool _notifyFreeGames;
  static bool get notifyFreeGames => _notifyFreeGames;

  static late bool _openInStore;
  static bool get openInStore => _openInStore;

  static late bool _openInApp;
  static bool get openInApp => _openInApp;

  static late bool _showExtendedInfo;
  static bool get showExtendedInfo => _showExtendedInfo;

  static late bool _showSteamReviews;
  static bool get showSteamReviews => _showSteamReviews;

  static late bool _showSteamAchievements;
  static bool get showSteamAchievements => _showSteamAchievements;

  static late bool _showMetacriticScore;
  static bool get showMetacriticScore => _showMetacriticScore;

  static late List<Store>? _stores;
  static List<Store>? get stores => _stores;

  static late int _dateStoresFetched;
  static int get dateStoresFetched => _dateStoresFetched;

  // Filter Options

  static late Map<String, bool>? _storesFilter;
  static Map<String, bool>? get storesFilter => _storesFilter;

  static late double _startPriceRangeFilter;
  static double get startPriceRangeFilter => _startPriceRangeFilter;

  static late double _endPriceRangeFilter;
  static double get endPriceRangeFilter => _endPriceRangeFilter;

  static late double _metacriticScoreFilter;
  static double get metacriticScoreFilter => _metacriticScoreFilter;

  static late double _steamRatingFilter;
  static double get steamRatingFilter => _steamRatingFilter;

  static late bool _isAAAGameFilter;
  static bool get isAAAGameFilter => _isAAAGameFilter;

  static late bool _isOnSaleFilter;
  static bool get isOnSaleFilter => _isOnSaleFilter;

  // Sort Options
  static late String _sortByOption;
  static String get sortByOptionSelected => _sortByOption;

  static late String _sortByDirection;
  static String get sortByDirectionSelected => _sortByDirection;

  static late int _pageSize;
  static int get pageSize => _pageSize;

  static bool get sortIsDescending => _sortByDirection == "desc";

  static Map<String, String> get sortByOptions => {
        "Deal Rating": Localization.xSort.dealRating,
        "Title": Localization.xSort.title,
        "Savings": Localization.xSort.savings,
        "Price": Localization.xSort.price,
        "Metacritic": Localization.xSort.metacriticScore,
        "Reviews": Localization.xSort.steamRating,
        "Release": Localization.xSort.release,
        "Store": Localization.xSort.store,
        "Recent": Localization.xSort.recent,
      };

  static Map<String, String> get sortByDirections => {
        "asc": Localization.xSort.ascending,
        "desc": Localization.xSort.descending,
      };

  static Map<String, int> get pageSizeOptions => {
        "10": 10,
        "20": 20,
        "30": 30,
        "40": 40,
        "50": 50,
      };

  static Map<String, String> get languages => {
        "es-ES": "Español",
        "en-US": "English",
      };

  static Map<String, String> get gameLanguages => {
        "es-ES": "spanish",
        "en-US": "english",
      };

  static Map<String, String> get currencies => {
        "us": "USD",
        "es": "€",
        "gb": "£",
        "ar": "ARS\$",
      };

  //! Settings Methods

  static Future<void> setAppLanguage(String appLang) async {
    _appLang = appLang;
    await UtilPreferences.prefs.setString(UtilPreferences.appLang, _appLang);
  }

  static Future<void> setGameDataLang(String gameDataLang) async {
    _gameDataLang = gameDataLang;
    await UtilPreferences.prefs.setString(UtilPreferences.gameDataLang, _gameDataLang);
  }

  static Future<void> setCurrency(String currency) async {
    _currency = currency;
    await UtilPreferences.prefs.setString(UtilPreferences.currency, _currency);
  }

  static Future<void> setNotifyFreeGames(bool notify) async {
    _notifyFreeGames = notify;
    await UtilPreferences.prefs.setBool(UtilPreferences.notifyFreeGames, _notifyFreeGames);
  }

  static Future<void> setOpenInStore(bool openInStore) async {
    _openInStore = openInStore;
    await UtilPreferences.prefs.setBool(UtilPreferences.openInStore, _openInStore);
  }

  static Future<void> setOpenInApp(bool openInApp) async {
    _openInApp = openInApp;
    await UtilPreferences.prefs.setBool(UtilPreferences.openInApp, _openInApp);
  }

  static Future<void> setShowExtendedInfo(bool showExtendedInfo) async {
    _showExtendedInfo = showExtendedInfo;
    await UtilPreferences.prefs.setBool(UtilPreferences.showExtendedInfo, _showExtendedInfo);
  }

  static Future<void> setShowSteamReviews(bool showSteamReviews) async {
    _showSteamReviews = showSteamReviews;
    await UtilPreferences.prefs.setBool(UtilPreferences.showSteamReviews, _showSteamReviews);
  }

  static Future<void> setShowSteamAchievements(bool showSteamAchievements) async {
    _showSteamAchievements = showSteamAchievements;
    await UtilPreferences.prefs.setBool(
      UtilPreferences.showSteamAchievements,
      _showSteamAchievements,
    );
  }

  static Future<void> setShowMetacriticScore(bool showMetacriticScore) async {
    _showMetacriticScore = showMetacriticScore;
    await UtilPreferences.prefs.setBool(UtilPreferences.showMetacriticScore, _showMetacriticScore);
  }

  static Future<void> setStores(List<Store> stores) async {
    _stores = stores;
    await UtilPreferences.prefs.setString(UtilPreferences.stores, json.encode(_stores));
  }

  static Future<void> setDateStoresFetched(DateTime date) async {
    _dateStoresFetched = date.millisecondsSinceEpoch;
    await UtilPreferences.prefs.setInt(UtilPreferences.dateStoresFetched, _dateStoresFetched);
  }

  //! Filter Methods

  static Future<void> setStoresFilter(Map<String, bool> stores) async {
    _storesFilter = stores;
    await UtilPreferences.prefs.setString(UtilPreferences.storesFilter, json.encode(_storesFilter));
  }

  static Future<void> setStartPriceRangeFilter(double startPrice) async {
    _startPriceRangeFilter = startPrice;
    await UtilPreferences.prefs.setDouble(UtilPreferences.startPriceRangeFilter, _startPriceRangeFilter);
  }

  static Future<void> setEndPriceRangeFilter(double endPrice) async {
    _endPriceRangeFilter = endPrice;
    await UtilPreferences.prefs.setDouble(UtilPreferences.endPriceRangeFilter, _endPriceRangeFilter);
  }

  static Future<void> setMetacriticScoreFilter(double metacriticScore) async {
    _metacriticScoreFilter = metacriticScore;
    await UtilPreferences.prefs.setDouble(UtilPreferences.metacriticScoreFilter, _metacriticScoreFilter);
  }

  static Future<void> setSteamRatingFilter(double steamRating) async {
    _steamRatingFilter = steamRating;
    await UtilPreferences.prefs.setDouble(UtilPreferences.steamRatingFilter, _steamRatingFilter);
  }

  static Future<void> setIsAAAGameFilter(bool isAAAGame) async {
    _isAAAGameFilter = isAAAGame;
    await UtilPreferences.prefs.setBool(UtilPreferences.isAAAGameFilter, _isAAAGameFilter);
  }

  static Future<void> setIsOnSaleFilter(bool isOnSale) async {
    _isOnSaleFilter = isOnSale;
    await UtilPreferences.prefs.setBool(UtilPreferences.isOnSaleFilter, _isOnSaleFilter);
  }

  //! Sort Methods

  static Future<void> setSortByOption(String sortByOption) async {
    _sortByOption = sortByOption;
    await UtilPreferences.prefs.setString(UtilPreferences.sortByOption, _sortByOption);
  }

  static Future<void> setSortByDirection(String sortByDirection) async {
    _sortByDirection = sortByDirection;
    await UtilPreferences.prefs.setString(UtilPreferences.sortByDirection, _sortByDirection);
  }

  static Future<void> setPageSize(int pageSize) async {
    _pageSize = pageSize;
    await UtilPreferences.prefs.setInt(UtilPreferences.pageSize, _pageSize);
  }

  static void load() {
    //! Settings
    _appLang = UtilPreferences.prefs.getString(UtilPreferences.appLang) ?? _getPlatformLang();
    _gameDataLang = UtilPreferences.prefs.getString(UtilPreferences.gameDataLang) ?? _appLang;
    _currency = UtilPreferences.prefs.getString(UtilPreferences.currency) ?? "us";
    _notifyFreeGames = UtilPreferences.prefs.getBool(UtilPreferences.notifyFreeGames) ?? true;
    _openInStore = UtilPreferences.prefs.getBool(UtilPreferences.openInStore) ?? true;
    _openInApp = UtilPreferences.prefs.getBool(UtilPreferences.openInApp) ?? true;
    _showExtendedInfo = UtilPreferences.prefs.getBool(UtilPreferences.showExtendedInfo) ?? true;
    _showSteamReviews = UtilPreferences.prefs.getBool(UtilPreferences.showSteamReviews) ?? true;
    _showSteamAchievements = UtilPreferences.prefs.getBool(UtilPreferences.showSteamAchievements) ?? true;
    _showMetacriticScore = UtilPreferences.prefs.getBool(UtilPreferences.showMetacriticScore) ?? true;
    _stores = UtilPreferences.decodeStores();
    _dateStoresFetched = UtilPreferences.prefs.getInt(UtilPreferences.dateStoresFetched) ?? 0;

    //! Filter
    _storesFilter = UtilPreferences.decodeStoresFilter();
    _startPriceRangeFilter = UtilPreferences.prefs.getDouble(UtilPreferences.startPriceRangeFilter) ?? 0;
    _endPriceRangeFilter = UtilPreferences.prefs.getDouble(UtilPreferences.endPriceRangeFilter) ?? 50;
    _metacriticScoreFilter = UtilPreferences.prefs.getDouble(UtilPreferences.metacriticScoreFilter) ?? 0;
    _steamRatingFilter = UtilPreferences.prefs.getDouble(UtilPreferences.steamRatingFilter) ?? 0;
    _isAAAGameFilter = UtilPreferences.prefs.getBool(UtilPreferences.isAAAGameFilter) ?? false;
    _isOnSaleFilter = UtilPreferences.prefs.getBool(UtilPreferences.isOnSaleFilter) ?? false;

    //! Sort
    _sortByOption = UtilPreferences.prefs.getString(UtilPreferences.sortByOption) ?? "Deal Rating";
    _sortByDirection = UtilPreferences.prefs.getString(UtilPreferences.sortByDirection) ?? "asc";
    _pageSize = UtilPreferences.prefs.getInt(UtilPreferences.pageSize) ?? 10;
  }

  static String _getPlatformLang() {
    return Platform.localeName.startsWith("es") ? "es-ES" : "en-US";
  }

  static String? getJoinedStoresId() {
    Map<String, bool> aux = Map.from(_storesFilter!);
    aux.removeWhere((key, value) => !value);

    return aux.length == _storesFilter!.length ? null : aux.keys.join(",");
  }
}
