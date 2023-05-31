import 'package:flutter/material.dart';

import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/util/app_settings.dart';
import '../../../core/framework/util/general_navigator.dart';
import '../../../core/framework/util/notification_handler.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/entities/tuki_notification.dart';
import '../../widgets/common/center_circle_loading/center_circle_loading.dart';
import '../../widgets/common/cool_app_bar/cool_app_bar.dart';
import '../../widgets/common/simple_button/simple_button.dart';
import '../../widgets/common/simple_scroll/simple_scroll.dart';
import '../../widgets/error_message/error_message.dart';
import 'widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationHandler _notificationHandler = NotificationHandler();
  List<TukiNotification> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    _getNotifications();
    super.initState();
  }

  void _getNotifications() async {
    await _notificationHandler.populate().then((notifications) {
      setState(() {
        _notifications = List.from(notifications);
        _isLoading = false;
      });
      NotificationHandler.hasNewNotifications.value = false;
    });
  }

  void onDeleteNotification(int index) {
    setState(() {
      TukiNotification removeNotification = _notifications.removeAt(index);
      _notificationHandler.remove(removeNotification.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoolAppBar(
        title: Localization.xNotifications.title,
        showBackButton: true,
        showLogo: false,
        showActionButtons: false,
      ),
      body: _isLoading
          ? const CenterCircleLoading()
          : _notifications.isEmpty
              ? ErrorMessage(
                  image: "assets/images/general/empty_notifications.json",
                  text: Localization.xNotifications.empty,
                  child: SimpleButton(
                    text: Localization.xCommon.goBackToHome,
                    onTap: () => GeneralNavigator.pop(),
                  ),
                )
              : SimpleScroll(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      TukiNotification notification = _notifications[index];
                      Store store = AppSettings.stores!.firstWhere((store) => store.id == notification.storeId);

                      return NotificationItem(
                        notification: notification,
                        store: store,
                        index: index,
                        onDelete: onDeleteNotification,
                      );
                    },
                  ),
                ),
    );
  }
}
