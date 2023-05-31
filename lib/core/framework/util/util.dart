import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localization/localization.dart';
import '../theme/theme_manager.dart';
import 'app_settings.dart';
import 'cool_snack_bar.dart';

class Util {
  static DateTime? _currentBackPressTime;
  static final List<int> _clamiedGames = [];

  static List<int> get claimedGames => _clamiedGames;
  static Size sizeAppBar = const Size.fromHeight(60);

  static Future<void> openUrl(String url, {bool openFromNotification = false}) async {
    final Uri uriUrl = Uri.parse(url);

    if (openFromNotification) {
      await launchUrl(uriUrl);
    } else {
      late final bool externalApplicationSucceded;

      if (AppSettings.openInStore) {
        externalApplicationSucceded = await launchUrl(
          uriUrl,
          mode: LaunchMode.externalNonBrowserApplication,
        );

        if (!externalApplicationSucceded) {
          await launchUrl(
            uriUrl,
            mode: AppSettings.openInApp ? LaunchMode.inAppWebView : LaunchMode.externalApplication,
          );
        }
      } else {
        await launchUrl(
          uriUrl,
          mode: AppSettings.openInApp ? LaunchMode.inAppWebView : LaunchMode.externalApplication,
        );
      }
    }
  }

  static Future<bool> downloadFile(String urlPDF) async {
    final Uri url = Uri.parse(urlPDF);

    final bool externalApplicationSucceded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!externalApplicationSucceded) {
      return launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      return Future.value(true);
    }
  }

  static Future<bool> doubleTapToExit(BuildContext context) {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null || now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      CoolSnackBar.of(context).custom(
        text: Localization.xCommon.doubleBackTap,
        margin: const EdgeInsets.fromLTRB(80, 0, 80, 50),
        padding: const EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(30),
        dismissDirection: DismissDirection.none,
        mainAxisAlignment: MainAxisAlignment.center,
        backgroundColor: ThemeManager.kPrimaryColor,
      );
      return Future.value(false);
    }

    return Future.value(true);
  }

  static bool isNewerVersion(String actualVersion, String newVersion) {
    List<String> actualVersionSplitted = actualVersion.split(".");
    List<String> newVersionSplitted = newVersion.split(".");

    int majorActualVersion = int.parse(actualVersionSplitted[0]);
    int minorActualVersion = int.parse(actualVersionSplitted[1]);
    int revisionActualVersion = int.parse(actualVersionSplitted[2]);

    int majorNewerVersion = int.parse(newVersionSplitted[0]);
    int minorNewerVersion = int.parse(newVersionSplitted[1]);
    int revisionNewerVersion = int.parse(newVersionSplitted[2]);

    if (majorNewerVersion > majorActualVersion) return true;
    if (majorNewerVersion == majorActualVersion && minorNewerVersion > minorActualVersion) return true;
    if (majorNewerVersion == majorActualVersion && minorNewerVersion == minorActualVersion && revisionNewerVersion > revisionActualVersion) {
      return true;
    }

    return false;
  }

  static getGreenButtonName(double price) {
    return price == 0 ? Localization.xCommon.claim : Localization.xCommon.buy;
  }
}
