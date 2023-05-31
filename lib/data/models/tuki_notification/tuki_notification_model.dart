import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/tuki_notification.dart';

part 'tuki_notification_model.g.dart';

@JsonSerializable()
class TukiNotificationModel extends TukiNotification {
  const TukiNotificationModel({
    required super.id,
    required super.gameName,
    required super.gameId,
    required super.dealId,
    required super.storeId,
    required super.price,
    required super.imageUrl,
    required super.date,
  }) : super(
          dealUrl: "https://www.cheapshark.com/redirect?dealID=$dealId",
        );

  @override
  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch, toJson: toEpoch)
  DateTime get date => super.date;

  factory TukiNotificationModel.fromJson(Map<String, dynamic> json) {
    return _$TukiNotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TukiNotificationModelToJson(this);
  }
}

int toEpoch(DateTime value) => value.millisecondsSinceEpoch;
