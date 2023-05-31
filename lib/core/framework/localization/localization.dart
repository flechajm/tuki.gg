import 'package:easy_localization/easy_localization.dart';

/// Class dedicated to manage the app localization.
///
/// Includes:
///
/// * Notifications `NotificationsLocalization`
/// * Common `CommonLocalization`
/// * Home `HomeLocalization`
/// * Search `SearchLocalization`
/// * Sort `SortLocalization`
/// * GameCard `GameCardLocalization`
/// * GameDetail`GameDetailLocalization`
/// * Settings `SettingsLocalization`
/// * About `AboutLocalization`
/// * DateFormat `DateFormatsLocalization`
/// * Errors `ErrorsLocalization`
class Localization {
  /// Common Localization.
  static late NotificationsLocalization xNotifications;

  /// Common Localization.
  static late CommonLocalization xCommon;

  /// Home Localization.
  static late HomeLocalization xHome;

  /// Search Localization.
  static late SearchLocalization xSearch;

  /// Sort Localization.
  static late SortLocalization xSort;

  /// GameCard Localization.
  static late GameCardLocalization xGameCard;

  /// GameDetail Localization.
  static late GameDetailLocalization xGameDetail;

  /// Home Localization.
  static late SettingsLocalization xSettings;

  /// DateFormats Localization.
  static late DateFormatsLocalization xDateFormat;

  /// About Localization
  static late AboutLocalization xAbout;

  /// Errors Localization
  static late ErrorsLocalization xErrors;

  static Future<void> init() async {
    return await Future.microtask(() {
      xNotifications = NotificationsLocalization._instance();
      xCommon = CommonLocalization._instance();
      xHome = HomeLocalization._instance();
      xSearch = SearchLocalization._instance();
      xSort = SortLocalization._instance();
      xGameCard = GameCardLocalization._instance();
      xGameDetail = GameDetailLocalization._instance();
      xSettings = SettingsLocalization._instance();
      xAbout = AboutLocalization._instance();
      xDateFormat = DateFormatsLocalization._instance();
      xErrors = ErrorsLocalization._instance();
    });
  }
}

class NotificationsLocalization {
  final title = tr("notifications.title");
  final _header = "notifications.header";
  final body = tr("notifications.body");
  final _contentTitle = "notifications.contentTitle";
  final _summary = "notifications.summary";
  final empty = tr("notifications.empty");

  String header({required String gameTitle}) {
    return _header.tr(
      namedArgs: {"title": gameTitle},
    );
  }

  String contentTitle({required String gameTitle}) {
    return _contentTitle.tr(
      namedArgs: {"title": gameTitle},
    );
  }

  String summary({required double price}) {
    return _summary.tr(namedArgs: {
      "price": price.toStringAsFixed(2),
    });
  }

  NotificationsLocalization._instance();
}

class CommonLocalization {
  final tuki = tr("common.tuki");
  final claim = tr("common.claim");
  final buy = tr("common.buy");
  final ok = tr("common.ok");
  final apply = tr("common.apply");
  final cancel = tr("common.cancel");
  final back = tr("common.back");
  final share = tr("common.share");
  final doubleBackTap = tr("common.doubleBackTap");
  final goToStore = tr("common.goToStore");
  final goBackToHome = tr("common.goBackToHome");

  CommonLocalization._instance();
}

class HomeLocalization {
  final searchAgain = tr("home.searchAgain");

  HomeLocalization._instance();
}

class SearchLocalization {
  final title = tr("search.title");
  final hint = tr("search.hint");
  final tooltipErase = tr("search.tooltipErase");
  final tooltipFilter = tr("search.tooltipFilter");
  final tooltipClose = tr("search.tooltipClose");
  final tooltipResetFilter = tr("search.tooltipResetFilter");
  final popupTitle = tr("search.popupTitle");
  final aaaGame = tr("search.aaaGame");
  final onSale = tr("search.onSale");

  final SearchStoresLocalization xStores = SearchStoresLocalization._instance();
  final SearchPriceRangeLocalizatiton xPriceRange = SearchPriceRangeLocalizatiton._instance();
  final SearchSteamRatingLocalizatiton xSteamRating = SearchSteamRatingLocalizatiton._instance();
  final SearchMetacriticScoreLocalization xMetacriticScore = SearchMetacriticScoreLocalization._instance();

  SearchLocalization._instance();
}

class SearchStoresLocalization {
  final title = tr("search.stores.title");
  final oneSelected = tr("search.stores.oneSelected");
  final _multiSelected = "search.stores.multiSelected";
  final selectAll = tr("search.stores.selectAll");
  final selectNone = tr("search.stores.selectNone");

  String multiSelected({required int quantity}) {
    return _multiSelected.tr(namedArgs: {
      "quantity": quantity.toString(),
    });
  }

  SearchStoresLocalization._instance();
}

class SearchPriceRangeLocalizatiton {
  final title = tr("search.priceRange.title");
  final free = tr("search.priceRange.free");

  SearchPriceRangeLocalizatiton._instance();
}

class SearchSteamRatingLocalizatiton {
  final title = tr("search.steamRating.title");
  final any = tr("search.steamRating.any");

  SearchSteamRatingLocalizatiton._instance();
}

class SearchMetacriticScoreLocalization {
  final title = tr("search.metacriticScore.title");
  final any = tr("search.metacriticScore.any");

  SearchMetacriticScoreLocalization._instance();
}

class SortLocalization {
  final tooltip = tr("sort.tooltip");
  final popupTitle = tr("sort.popupTitle");
  final orderBy = tr("sort.orderBy");
  final sortDirection = tr("sort.sortDirection");
  final ascending = tr("sort.ascending");
  final descending = tr("sort.descending");
  final dealRating = tr("sort.dealRating");
  final title = tr("sort.title");
  final savings = tr("sort.savings");
  final price = tr("sort.price");
  final metacriticScore = tr("sort.metacriticScore");
  final steamRating = tr("sort.steamRating");
  final release = tr("sort.release");
  final store = tr("sort.store");
  final recent = tr("sort.recent");
  final pageSize = tr("sort.pageSize");

  SortLocalization._instance();
}

class GameCardLocalization {
  final free = tr("gameCard.free");
  final _share = "gameCard.share";

  String share({required String title, required String link}) {
    return _share.tr(namedArgs: {
      "title": title,
      "link": link,
    });
  }

  GameCardLocalization._instance();
}

class GameDetailLocalization {
  final title = tr("gameDetail.title");
  final categories = tr("gameDetail.categories");
  final genres = tr("gameDetail.genres");
  final developer = tr("gameDetail.developer");
  final publisher = tr("gameDetail.publisher");
  final releaseDate = tr("gameDetail.releaseDate");
  final _includeAchievements = "gameDetail.includeAchievements";
  final viewAllAchievements = tr("gameDetail.viewAllAchievements");

  String includeAchievements({required int total}) {
    return _includeAchievements.tr(namedArgs: {
      "total": total.toString(),
    });
  }

  final GameDetailPricesLocalization xPrices = GameDetailPricesLocalization._instance();

  final GameDetailSteamReviewsLocalization xSteamReviews = GameDetailSteamReviewsLocalization._instance();

  GameDetailLocalization._instance();
}

class GameDetailSteamReviewsLocalization {
  final title = tr("gameDetail.steamReviews.title");
  final _desc = "gameDetail.steamReviews.desc";
  final overwhelminglyPositive = tr("gameDetail.steamReviews.overwhelminglyPositive");
  final veryPositive = tr("gameDetail.steamReviews.veryPositive");
  final positive = tr("gameDetail.steamReviews.positive");
  final mostlyPositive = tr("gameDetail.steamReviews.mostlyPositive");
  final mixed = tr("gameDetail.steamReviews.mixed");
  final mostlyNegative = tr("gameDetail.steamReviews.mostlyNegative");
  final veryNegative = tr("gameDetail.steamReviews.veryNegative");
  final overwhelminglyNegative = tr("gameDetail.steamReviews.overwhelminglyNegative");

  String description({required double percent, required int total}) {
    NumberFormat formatter = NumberFormat("##,###", "es_ES");

    return _desc.tr(namedArgs: {
      "percent": percent.toStringAsFixed(0),
      "total": formatter.format(total.truncate()),
    });
  }

  GameDetailSteamReviewsLocalization._instance();
}

class GameDetailPricesLocalization {
  final priceUSD = tr("gameDetail.prices.priceUSD");
  final normalPrice = tr("gameDetail.prices.normalPrice");
  final discount = tr("gameDetail.prices.discount");
  final finalPrice = tr("gameDetail.prices.finalPrice");

  GameDetailPricesLocalization._instance();
}

class SettingsLocalization {
  final title = tr("settings.title");
  final langCurrency = tr("settings.langCurrency");
  final externalLinks = tr("settings.externalLinks");
  final gameInfo = tr("settings.gameInfo");
  final appInterface = tr("settings.appInterface");
  final gameData = tr("settings.gameData");
  final gameDataDescription = tr("settings.gameDataDescription");
  final displayCurrency = tr("settings.displayCurrency");
  final displayCurrencyDescription = tr("settings.displayCurrencyDescription");
  final notifyFreeGames = tr("settings.notifyFreeGames");
  final openInStore = tr("settings.openInStore");
  final openInStoreDescription = tr("settings.openInStoreDescription");
  final openInApp = tr("settings.openInApp");
  final openInAppDescription = tr("settings.openInAppDescription");
  final steamInformation = tr("settings.steamInformation");
  final steamInformationDescription = tr("settings.steamInformationDescription");
  final steamPriceLocalized = tr("settings.steamPriceLocalized");
  final steamPriceLocalizedDescription = tr("settings.steamPriceLocalizedDescription");
  final showExtendedInfo = tr("settings.showExtendedInfo");
  final showExtendedInfoDescription = tr("settings.showExtendedInfoDescription");
  final showSteamReviews = tr("settings.showSteamReviews");
  final showSteamAchievements = tr("settings.showSteamAchievements");
  final showMetacriticScore = tr("settings.showMetacriticScore");

  SettingsLocalization._instance();
}

class DateFormatsLocalization {
  final shortDateTime = tr("dateFormats.shortDateTime");
  final shortDate = tr("dateFormats.shortDate");
  final shortTime = tr("dateFormats.shortTime");
  final largeDate = tr("dateFormats.largeDate");
  final largeDateTime = tr("dateFormats.largeDateTime");

  DateFormatsLocalization._instance();
}

class AboutLocalization {
  final title = tr("about.title");
  final version = tr("about.version");
  final madeIn = tr("about.madeIn");
  final copyright = tr("about.copyright");
  final developedBy = tr("about.developedBy");
  final poweredBy = tr("about.poweredBy");

  AboutLocalization._instance();
}

class ErrorsLocalization {
  final empty = tr("errors.empty");
  final fail = tr("errors.fail");

  ErrorsLocalization._instance();
}
