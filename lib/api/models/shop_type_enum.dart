// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ShopTypeEnum {
  /// Incorrect name has been replaced. Original name: `[main_package]`.
  @JsonValue('[main_package]')
  undefined0('[main_package]'),

  /// Incorrect name has been replaced. Original name: `[additional_package]`.
  @JsonValue('[additional_package]')
  undefined1('[additional_package]'),

  /// Incorrect name has been replaced. Original name: `[checkin_package]`.
  @JsonValue('[checkin_package]')
  undefined2('[checkin_package]'),
  @JsonValue('debuff_package')
  debuffPackage('debuff_package'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ShopTypeEnum(this.json);

  factory ShopTypeEnum.fromJson(dynamic json) =>
      values.firstWhere((e) => e.json == json, orElse: () => $unknown);

  final dynamic json;

  @override
  String toString() => json ?? super.toString();

  /// Returns all defined enum values excluding the $unknown value.
  static List<ShopTypeEnum> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
