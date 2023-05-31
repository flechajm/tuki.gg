import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

import '../../../data/models/tuki_notification/tuki_notification_model.dart';
import '../../../domain/entities/tuki_notification.dart';

class NotificationHandler {
  static ValueNotifier<bool> hasNewNotifications = ValueNotifier<bool>(false);

  late List<TukiNotification> _notifications;

  Future<List<TukiNotification>> populate() async {
    _notifications = await _get();
    return _notifications;
  }

  Future<String> _getPath() async {
    final Directory directory = await getTemporaryDirectory();
    final String path = '${directory.path}/notifications';
    final File file = File(path);

    if (!await file.exists()) await file.create();

    return path;
  }

  bool exists(String notificationId) {
    return _notifications.any((notification) => notification.id == notificationId);
  }

  Future<void> add(TukiNotification notification) async {
    _notifications.add(notification);
    await _save(_notifications);
    _notifications = await _get();
  }

  Future<void> remove(String notificationId) async {
    bool notifExists = exists(notificationId);

    if (notifExists) {
      _notifications.removeWhere((notification) => notification.id == notificationId);
      await _save(_notifications);
      _notifications = await _get();
    }
  }

  Future<void> _save(List<TukiNotification> notifications) async {
    final String path = await _getPath();
    final File file = File(path);

    await file.writeAsString(json.encode(notifications));
  }

  Future<List<TukiNotification>> _get() async {
    final String path = await _getPath();
    final File file = File(path);
    String jsonData = await file.readAsString();

    if (jsonData.isEmpty) return Future.value([]);

    List<TukiNotification> notifications = _decodeNotifications(jsonData);
    notifications.sort((a, b) => b.date.compareTo(a.date));

    return notifications;
  }

  List<TukiNotification> _decodeNotifications(String data) {
    Iterable dataList = json.decode(data);
    return List<TukiNotificationModel>.from(dataList.map((store) => TukiNotificationModel.fromJson(store)));
  }

  static Future<void> registerNotifications() async {
    await Workmanager().registerPeriodicTask(
      DateTime.now().millisecondsSinceEpoch.toString(),
      "freeGames",
      frequency: const Duration(hours: 1),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static Future<void> cancelNotifications() async {
    await Workmanager().cancelAll();
  }
}
