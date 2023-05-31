// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuki_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TukiNotificationModel _$TukiNotificationModelFromJson(
        Map<String, dynamic> json) =>
    TukiNotificationModel(
      id: json['id'] as String,
      gameName: json['gameName'] as String,
      gameId: json['gameId'] as int,
      dealId: json['dealId'] as String,
      storeId: json['storeId'] as int,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
    );

Map<String, dynamic> _$TukiNotificationModelToJson(
        TukiNotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameName': instance.gameName,
      'gameId': instance.gameId,
      'dealId': instance.dealId,
      'storeId': instance.storeId,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'date': toEpoch(instance.date),
    };
