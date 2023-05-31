import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/store/store_model.dart';
import '../../../data/models/tuki_notification/tuki_notification_model.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/entities/tuki_notification.dart';

export 'package:shared_preferences/shared_preferences.dart';

class UtilPreferences {
  //! Settings
  static const appLang = "appLang";
  static const gameDataLang = "gameDataLang";
  static const currency = "currency";
  static const notifyFreeGames = "notifyFreeGames";
  static const openInStore = "openInStore";
  static const openInApp = "openInApp";
  static const showExtendedInfo = "showExtendedInfo";
  static const showSteamReviews = "showSteamReviews";
  static const showSteamAchievements = "showSteamAchievements";
  static const showMetacriticScore = "showMetacriticScore";
  static const stores = "stores";
  static const dateStoresFetched = "dateStoresFetched";
  static const notifications = "notifications";

  //! Filter
  static const storesFilter = "storesFilter";
  static const startPriceRangeFilter = "startPriceRangeFilter";
  static const endPriceRangeFilter = "endPriceRangeFilter";
  static const metacriticScoreFilter = "metacriticScoreFilter";
  static const steamRatingFilter = "steamRatingFilter";
  static const isAAAGameFilter = "isAAAGameFilter";
  static const isOnSaleFilter = "isOnSaleFilter";

  //! Sort
  static const sortByOption = "sortByOption";
  static const sortByDirection = "sortOption";
  static const pageSize = "pageSize";

  static final UtilPreferences _singleton = UtilPreferences._internal();
  static late SharedPreferences prefs;

  factory UtilPreferences() {
    return _singleton;
  }

  UtilPreferences._internal();

  static Map<String, dynamic>? decodeJsonKey(String key) {
    String? pref = UtilPreferences.prefs.getString(key);
    if (pref == null) return null;

    return json.decode(pref);
  }

  static List<Store>? decodeStores() {
    String? pref = UtilPreferences.prefs.getString(stores);
    if (pref == null) return null;

    Iterable dataList = json.decode(pref);
    return List<StoreModel>.from(dataList.map((store) => StoreModel.fromJsonSaved(store)));
  }

  static List<TukiNotification> decodeNotifications() {
    String? pref = UtilPreferences.prefs.getString(notifications);
    if (pref == null) return [];

    Iterable dataList = json.decode(pref);
    return List<TukiNotificationModel>.from(dataList.map((store) => TukiNotificationModel.fromJson(store)));
  }

  static Map<String, bool>? decodeStoresFilter() {
    String? pref = UtilPreferences.prefs.getString(storesFilter);
    if (pref == null) return null;

    Map<String, bool> map = Map.from(json.decode(pref));

    return map;
  }
}
