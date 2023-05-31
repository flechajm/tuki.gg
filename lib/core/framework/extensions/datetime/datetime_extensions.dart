import 'package:easy_localization/easy_localization.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/date_symbol_data_local.dart';

import '../../localization/localization.dart';
import '../../util/app_settings.dart';

extension FormatDate on DateTime {
  String? _getLocale() {
    initializeDateFormatting(AppSettings.appLang, null);

    return AppSettings.appLang;
  }

  /// Converts the datetime to a custom format.
  ///
  /// If the parameter [format] is null, it will formatted to a short datetime.
  ///
  /// You can see the patterns and formats here: https://api.flutter.dev/flutter/intl/DateFormat-class.html
  String format(String? format, {bool convertToLocal = true}) {
    return DateFormat(format ?? Localization.xDateFormat.shortDateTime, _getLocale()).format(convertToLocal ? toLocal() : toUtc());
  }

  /// Converts the format to large date.
  ///
  /// For example, could be (depends of the locale): `February 20, 2022`.
  String largeDate({bool convertToLocal = true}) {
    return DateFormat(Localization.xDateFormat.largeDate, _getLocale()).format(convertToLocal ? toLocal() : toUtc());
  }

  /// Converts the format to large datetime.
  ///
  /// For example, could be (depends of the locale): `February 20, 2022 - 07:40 pm`.
  String largeDateTime({bool convertToLocal = true}) {
    return DateFormat(Localization.xDateFormat.largeDateTime, _getLocale()).format(convertToLocal ? toLocal() : toUtc());
  }

  /// Converts the format to short date.
  ///
  /// For example, could be (depends of the locale): `12/31/2022`.
  String shortDate({bool convertToLocal = true}) {
    return DateFormat(Localization.xDateFormat.shortDate, _getLocale()).format(convertToLocal ? toLocal() : toUtc());
  }

  /// Converts the format to short time.
  ///
  /// For example, could be (depends of the locale): `13:24` or `01:24 pm`.
  String shortTime({bool convertToLocal = true}) {
    return DateFormat(Localization.xDateFormat.shortTime, _getLocale()).format(convertToLocal ? toLocal() : toUtc());
  }

  /// Converts the date to a short word.
  ///
  /// For example: For a day whose date is Monday, it returns `Mon.`.
  String sentenceShortDate({bool convertToLocal = true}) {
    return toBeginningOfSentenceCase(DateFormat("EE", _getLocale()).format(convertToLocal ? toLocal() : toUtc()))!;
  }

  /// Converts the date to a word.
  ///
  /// For example: For a day whose date is Monday, it returns `Monday`.
  String sentenceLargeDate({bool convertToLocal = true}) {
    return toBeginningOfSentenceCase(DateFormat("EEEE", _getLocale()).format(convertToLocal ? toLocal() : toUtc()))!;
  }
}

extension DateTimeFromMilliseconds on DateTime {
  static DateTime parse(int milliseconds) => DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
  static DateTime? parseNullable(int? milliseconds) => milliseconds != null ? DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true) : null;
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
