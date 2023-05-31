import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/store.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel extends Store {
  @override
  @JsonKey(name: "storeID", fromJson: toInt)
  int get id => super.id;

  @override
  @JsonKey(name: "storeName")
  String get name => super.name;

  @override
  @JsonKey(fromJson: toBool)
  bool get isActive => super.isActive;

  const StoreModel({
    required super.id,
    required super.name,
    required super.isActive,
  }) : super(
            iconUrl: "https://www.cheapshark.com/img/stores/icons/${id - 1}.png",
            bannerUrl: "https://www.cheapshark.com/img/stores/banners/${id - 1}.png");

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return _$StoreModelFromJson(json);
  }

  factory StoreModel.fromJsonSaved(Map<String, dynamic> json) {
    return StoreModel(
      id: json["storeID"],
      name: json["storeName"],
      isActive: json["isActive"],
    );
  }

  Map<String, dynamic> toJson() {
    return _$StoreModelToJson(this);
  }
}

int toInt(String value) => int.parse(value);
bool toBool(int value) => value == 1;
