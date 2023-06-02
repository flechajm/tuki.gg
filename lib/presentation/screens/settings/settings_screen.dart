import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/theme/theme_manager.dart';
import '../../../core/framework/util/app_settings.dart';
import '../../../core/framework/util/general_navigator.dart';
import '../../../core/framework/util/notification_handler.dart';
import '../../../core/framework/util/util.dart';
import '../../widgets/common/cool_app_bar/cool_app_bar.dart';
import '../../widgets/common/simple_dropdown/simlpe_dropdown.dart';
import '../../widgets/common/simple_scroll/simple_scroll.dart';
import '../../widgets/common/text_link/text_link.dart';
import '../../widgets/steam_pill/steam_pill.dart';
import '../about/about_screen.dart';
import '../home/home_screen.dart';
import 'widgets/header_title.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _appLang;
  PackageInfo? _packageInfo;

  @override
  void initState() {
    _appLang = AppSettings.appLang;
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() => _packageInfo = packageInfo);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_appLang != AppSettings.appLang) {
          GeneralNavigator.push(const HomeScreen());
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: CoolAppBar(
          showBackButton: true,
          showLogo: false,
          showActionButtons: false,
          onTapBack: _appLang != AppSettings.appLang ? () => GeneralNavigator.push(const HomeScreen()) : null,
          title: Localization.xSettings.title,
        ),
        body: SimpleScroll(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTitle(
                margin: const EdgeInsets.only(top: 20),
                text: Localization.xSettings.langCurrency,
                options: [
                  Option(
                    text: Localization.xSettings.appInterface,
                    value: SimpleDropdown(
                      items: AppSettings.languages,
                      value: AppSettings.appLang,
                      onChanged: (value) async {
                        if (value != AppSettings.appLang) {
                          List<String> newLocale = value!.split("-");
                          await context.setLocale(Locale(newLocale[0], newLocale[1]));
                          await AppSettings.setAppLanguage(value);
                          Localization.init().whenComplete(() => setState(() {}));
                        }
                      },
                    ),
                  ),
                  Option(
                    text: Localization.xSettings.gameData,
                    description: Localization.xSettings.gameDataDescription,
                    value: SimpleDropdown(
                      items: AppSettings.languages,
                      value: AppSettings.gameDataLang,
                      onChanged: (value) async {
                        if (value != AppSettings.gameDataLang) {
                          AppSettings.setGameDataLang(value!).whenComplete(() => setState(() {}));
                        }
                      },
                    ),
                  ),
                  Option(
                    text: Localization.xSettings.displayCurrency,
                    description: Localization.xSettings.displayCurrencyDescription,
                    value: SimpleDropdown(
                      width: 60,
                      items: AppSettings.currencies,
                      value: AppSettings.currency,
                      dropdownAlignment: Alignment.centerRight,
                      onChanged: (value) async {
                        if (value != AppSettings.currency) {
                          AppSettings.setCurrency(value!).whenComplete(() => setState(() {}));
                        }
                      },
                    ),
                  ),
                ],
              ),
              if (Platform.isAndroid)
                HeaderTitle(
                  margin: const EdgeInsets.only(top: 50),
                  text: Localization.xNotifications.title,
                  options: [
                    Option(
                      text: Localization.xSettings.notifyFreeGames,
                      value: Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: AppSettings.notifyFreeGames,
                        onChanged: (value) async {
                          if (value) {
                            await NotificationHandler.registerNotifications();
                          } else {
                            await NotificationHandler.cancelNotifications();
                          }
                          AppSettings.setNotifyFreeGames(value).whenComplete(() => setState(() {}));
                        },
                      ),
                    )
                  ],
                ),
              HeaderTitle(
                margin: const EdgeInsets.only(top: 50),
                text: Localization.xSettings.externalLinks,
                options: [
                  Option(
                    text: Localization.xSettings.openInStore,
                    description: Localization.xSettings.openInStoreDescription,
                    value: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: AppSettings.openInStore,
                      onChanged: (value) async {
                        AppSettings.setOpenInStore(value).whenComplete(() => setState(() {}));
                      },
                    ),
                  ),
                  Option(
                    text: Localization.xSettings.openInApp,
                    description: Localization.xSettings.openInAppDescription,
                    value: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: AppSettings.openInApp,
                      onChanged: (value) async {
                        AppSettings.setOpenInApp(value).whenComplete(() => setState(() {}));
                      },
                    ),
                  ),
                ],
              ),
              HeaderTitle(
                margin: const EdgeInsets.only(top: 50),
                text: Localization.xSettings.gameInfo,
                options: [
                  Option(
                    text: Localization.xSettings.steamInformation,
                    description: Localization.xSettings.steamInformationDescription,
                    value: const SteamPill(),
                  ),
                  Option(
                    text: Localization.xSettings.steamPriceLocalized,
                    description: Localization.xSettings.steamPriceLocalizedDescription,
                    value: const SteamPill(isSteam: true),
                  ),
                  Option(
                    text: Localization.xSettings.showExtendedInfo,
                    description: Localization.xSettings.showExtendedInfoDescription,
                    value: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: AppSettings.showExtendedInfo,
                      onChanged: (value) async {
                        AppSettings.setShowExtendedInfo(value).whenComplete(() => setState(() {}));
                      },
                    ),
                  ),
                  Option(
                    text: Localization.xSettings.showSteamReviews,
                    value: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: AppSettings.showSteamReviews,
                      onChanged: (value) async {
                        AppSettings.setShowSteamReviews(value).whenComplete(() => setState(() {}));
                      },
                    ),
                  ),
                  Option(
                    text: Localization.xSettings.showSteamAchievements,
                    value: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: AppSettings.showSteamAchievements,
                      onChanged: (value) async {
                        AppSettings.setShowSteamAchievements(value).whenComplete(() => setState(() {}));
                      },
                    ),
                  ),
                  Option(
                    text: Localization.xSettings.showMetacriticScore,
                    value: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: AppSettings.showMetacriticScore,
                      onChanged: (value) async {
                        AppSettings.setShowMetacriticScore(value).whenComplete(() => setState(() {}));
                      },
                    ),
                  ),
                ],
              ),
              HeaderTitle(
                margin: const EdgeInsets.only(top: 50),
                text: Localization.xLegals.title,
                options: [
                  Option(
                    text: Localization.xLegals.privacyPolicy,
                    value: TextLink(
                      Localization.xLegals.read,
                      textDecorationStyle: TextDecorationStyle.dotted,
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeManager.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () {
                        final String url = GlobalConfiguration().getValue("privacyPolicyUrl");
                        Util.openUrl(url);
                      },
                    ),
                  ),
                  Option(
                    text: Localization.xLegals.tos,
                    value: TextLink(
                      Localization.xLegals.read,
                      textDecorationStyle: TextDecorationStyle.dotted,
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeManager.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () {
                        final String url = GlobalConfiguration().getValue("termsOfServiceUrl");
                        Util.openUrl(url);
                      },
                    ),
                  ),
                ],
              ),
              HeaderTitle(
                margin: const EdgeInsets.only(top: 50, bottom: 30),
                text: Localization.xAbout.title,
                options: [
                  Option(
                    text: Localization.xAbout.version,
                    value: TextLink(
                      "v${_packageInfo?.version}",
                      textDecorationStyle: TextDecorationStyle.dotted,
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeManager.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () => GeneralNavigator.push(
                        AboutScreen(version: _packageInfo!.version),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
