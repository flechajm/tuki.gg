// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/easy_localization_controller.dart';
import 'package:easy_localization/src/localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tukigg/core/framework/extensions/datetime/datetime_extensions.dart';
import 'package:tukigg/core/framework/localization/localization.dart';
import 'package:tukigg/core/framework/util/notification_handler.dart';
import 'package:tukigg/core/http/http_client.dart';
import 'package:tukigg/core/network/network_info.dart';
import 'package:tukigg/data/datasources/deals_datasource.dart';
import 'package:tukigg/data/models/tuki_notification/tuki_notification_model.dart';
import 'package:tukigg/domain/usecases/deal_info/params/params_deal.dart';
import 'package:workmanager/workmanager.dart';

import 'core/framework/bloc/injection_container.dart' as injection;
import 'core/framework/theme/theme_manager.dart';
import 'core/framework/util/app_settings.dart';
import 'core/framework/util/notification_service.dart';
import 'core/framework/util/util.dart';
import 'core/framework/util/util_preferences.dart';
import 'data/models/deal_info/deal_info_model.dart';
import 'presentation/screens/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final NotificationService notificationService = NotificationService();

const taskName = "freeGames";

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == "freeGames") {
      UtilPreferences.prefs = await SharedPreferences.getInstance();
      NotificationHandler notificationHandler = NotificationHandler();
      notificationHandler.populate();

      AppSettings.load();

      await loadTranslationsInBackgroundProccess();
      await Localization.init();

      HttpClient myClient = HttpClient(
        client: http.Client(),
        networkInfo: NetworkInfo(InternetConnectionChecker()),
      );

      String data = await myClient.get(
        url: DealsDataSource.getUrl(
          ParamsDeal(priceRange: const RangeValues(0, 0)),
          completeUrl: true,
        ),
      );
      List dataList = json.decode(data);
      List<DealInfoModel> deals = dataList.map((deal) => DealInfoModel.fromJson(deal)).toList();

      for (var i = 0; i < deals.length; i++) {
        DealInfoModel deal = deals[i];

        String? largeIconPath = await _downloadAndSaveFile(deal.coverImage, 'notif_game_${deal.gameID}');
        String notificationId = "${deal.gameID}_${deal.storeID}_${DateTime.now().format("MMyyyy")}";

        if (!notificationHandler.findByElapsedTime(deal.gameID, 30)) {
          await notificationHandler.add(
            TukiNotificationModel(
              id: notificationId,
              gameName: deal.title,
              gameId: deal.gameID,
              dealId: deal.dealID,
              storeId: deal.storeID,
              price: deal.normalPrice,
              imageUrl: deal.coverImage,
              date: DateTime.now(),
            ),
          );

          await notificationService.show(
            id: deal.gameID,
            title: Localization.xNotifications.header(gameTitle: deal.title),
            body: Localization.xNotifications.body,
            payload: deal.dealUrl,
            dealInfo: deal,
            store: AppSettings.stores?.where((store) => store.id == deal.storeID).first.name,
            image: largeIconPath,
          );
        }
      }
    }

    return Future.value(true);
  });
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getTemporaryDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response responseImage = await http.get(Uri.parse(url));
  File file2 = File(filePath);
  await file2.writeAsBytes(responseImage.bodyBytes);

  return filePath;
}

Future<void> loadTranslationsInBackgroundProccess() async {
  await EasyLocalizationController.initEasyLocation();

  String locale = AppSettings.appLang;
  List<String> newLocale = locale.split("-");
  final controller = EasyLocalizationController(
    saveLocale: true,
    path: 'assets/lang',
    startLocale: Locale(newLocale[0], newLocale[1]),
    fallbackLocale: const Locale('es', 'ES'),
    supportedLocales: const [
      Locale('es', 'ES'),
      Locale('en', 'US'),
    ],
    assetLoader: const RootBundleAssetLoader(),
    useOnlyLangCode: false,
    useFallbackTranslations: false,
    onLoadError: (FlutterError e) {},
  );

  await controller.loadTranslations();

  easy.Localization.load(
    controller.locale,
    translations: controller.translations,
    fallbackTranslations: controller.fallbackTranslations,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  UtilPreferences.prefs = await SharedPreferences.getInstance();
  notificationService.init();
  notificationService.updateNotificationsStatus();

  await Workmanager().initialize(callbackDispatcher);

  NotificationAppLaunchDetails? notificationLaunch = await notificationService.getNotificationLaunch();

  if (notificationLaunch != null && notificationLaunch.didNotificationLaunchApp) {
    Util.openUrl(
      notificationLaunch.notificationResponse!.payload!,
      openFromNotification: true,
    );
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await GlobalConfiguration().loadFromPath('assets/config/app_settings.json');
  await injection.init();
  await EasyLocalization.ensureInitialized();

  AppSettings.load();

  if (AppSettings.notifyFreeGames) {
    PermissionStatus status = await Permission.notification.status;
    if (status.isDenied) {
      await notificationService.showDummy();
    }

    await Workmanager().registerPeriodicTask(
      DateTime.now().millisecondsSinceEpoch.toString(),
      taskName,
      frequency: const Duration(hours: 1),
      initialDelay: const Duration(minutes: 5),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      String locale = AppSettings.appLang;
      List<String> newLocale = locale.split("-");

      runApp(
        EasyLocalization(
          path: 'assets/lang',
          startLocale: Locale(newLocale[0], newLocale[1]),
          fallbackLocale: const Locale('es', 'ES'),
          supportedLocales: const [
            Locale('es', 'ES'),
            Locale('en', 'US'),
          ],
          child: const TukiGG(),
        ),
      );
    },
  );
}

class TukiGG extends StatefulWidget {
  const TukiGG({super.key});

  @override
  State<TukiGG> createState() => _TukiGGState();
}

class _TukiGGState extends State<TukiGG> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'tuki.gg',
      navigatorKey: navigatorKey,
      theme: ThemeManager.getTheme(context),
      home: const SplashScreen(),
    );
  }
}
