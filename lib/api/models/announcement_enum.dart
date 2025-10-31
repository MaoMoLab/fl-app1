// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum AnnouncementEnum {
  @JsonValue('index_ann')
  indexAnn('index_ann'),
  @JsonValue('pop_up_ann')
  popUpAnn('pop_up_ann'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const AnnouncementEnum(this.json);

  factory AnnouncementEnum.fromJson(String json) =>
      values.firstWhere((e) => e.json == json, orElse: () => $unknown);

  final String? json;

  @override
  String toString() => json ?? super.toString();

  /// Returns all defined enum values excluding the $unknown value.
  static List<AnnouncementEnum> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
