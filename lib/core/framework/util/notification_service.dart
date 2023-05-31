import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../domain/entities/deal_info.dart';
import '../localization/localization.dart';
import '../theme/theme_manager.dart';
import 'notification_handler.dart';
import 'util.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _settingsAndroid = const AndroidInitializationSettings('app_icon');
  final DarwinInitializationSettings _settingsIOS = const DarwinInitializationSettings();
  late final InitializationSettings initializationSettings;

  NotificationService() {
    initializationSettings = InitializationSettings(
      android: _settingsAndroid,
      iOS: _settingsIOS,
    );
  }

  init() async {
    _notifications.initialize(initializationSettings, onDidReceiveNotificationResponse: onReceiveNotification);
  }

  void updateNotificationsStatus() async {
    List<ActiveNotification> activeNotifications = await _notifications.getActiveNotifications();
    NotificationHandler.hasNewNotifications.value = activeNotifications.isNotEmpty;
  }

  Future<NotificationAppLaunchDetails?> getNotificationLaunch() {
    return _notifications.getNotificationAppLaunchDetails();
  }

  Future<NotificationDetails> _notificationDetails({
    required DealInfo dealInfo,
    String? largeIconPath,
    String? store,
  }) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'tuki.gg',
        'Free Games',
        importance: Importance.max,
        visibility: NotificationVisibility.public,
        color: ThemeManager.kPrimaryColor,
        largeIcon: largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
        subText: store,
        styleInformation: largeIconPath != null
            ? BigPictureStyleInformation(
                FilePathAndroidBitmap(largeIconPath),
                largeIcon: FilePathAndroidBitmap(largeIconPath),
                contentTitle: Localization.xNotifications.contentTitle(gameTitle: dealInfo.title),
                htmlFormatContentTitle: true,
                summaryText: Localization.xNotifications.summary(price: dealInfo.normalPrice),
                htmlFormatSummaryText: true,
              )
            : null,
      ),
    );
  }

  Future<void> show({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    String? image,
    required DealInfo dealInfo,
    String? store,
  }) async {
    NotificationDetails? notificationDetails = await _notificationDetails(
      dealInfo: dealInfo,
      store: store,
      largeIconPath: image,
    );

    return await _notifications.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<NotificationDetails> _getNotificationDetailsDummy() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'tuki.gg',
        'Free Games',
        importance: Importance.max,
        visibility: NotificationVisibility.public,
        color: ThemeManager.kPrimaryColor,
      ),
    );
  }

  Future<void> showDummy() async {
    NotificationDetails details = await _getNotificationDetailsDummy();
    return await _notifications.show(1, null, null, details);
  }
}

void onReceiveNotification(NotificationResponse notificationResponse) async {
  if (notificationResponse.payload != null) {
    NotificationService().updateNotificationsStatus();

    await Util.openUrl(
      notificationResponse.payload!,
      openFromNotification: true,
    );
  }
}
