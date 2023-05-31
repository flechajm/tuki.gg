import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/framework/extensions/datetime/datetime_extensions.dart';
import '../../../../core/framework/theme/theme_manager.dart';
import '../../../../core/framework/util/util.dart';
import '../../../../domain/entities/store.dart';
import '../../../../domain/entities/tuki_notification.dart';

class NotificationItem extends StatelessWidget {
  final TukiNotification notification;
  final Store store;
  final int index;
  final void Function(int) onDelete;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.store,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        onDelete(index);
      },
      background: Container(
        color: ThemeManager.kPrimaryColor,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30),
        child: const Icon(
          Icons.delete,
          size: 28,
          color: Colors.white,
        ),
      ),
      child: InkWell(
        splashColor: ThemeManager.kSecondaryColor,
        highlightColor: ThemeManager.kSecondaryColor40,
        onTap: () => Util.openUrl(notification.dealUrl),
        child: Container(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.zero,
                height: 90,
                width: double.infinity,
                foregroundDecoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: [0, 0.45],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    alignment: Alignment.centerRight,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    fit: BoxFit.fitHeight,
                    image: CachedNetworkImageProvider(notification.imageUrl),
                    colorFilter: const ColorFilter.mode(
                      Colors.black87,
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
              Container(
                height: 90,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.gameName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              store.name,
                              style: TextStyle(
                                color: ThemeManager.kSecondaryColor,
                                fontSize: 12,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "•",
                                style: TextStyle(
                                  color: ThemeManager.kSecondaryColor90,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              "\$${notification.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: ThemeManager.kSecondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                decorationStyle: TextDecorationStyle.solid,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            FontAwesomeIcons.bell,
                            color: Colors.white30,
                            size: 9,
                          ),
                        ),
                        Text(
                          "${notification.date.largeDateTime()} hs.",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white30,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
