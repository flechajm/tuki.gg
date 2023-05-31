// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      id: toInt(json['storeID'] as String),
      name: json['storeName'] as String,
      isActive: toBool(json['isActive'] as int),
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'storeID': instance.id,
      'storeName': instance.name,
      'isActive': instance.isActive,
    };
