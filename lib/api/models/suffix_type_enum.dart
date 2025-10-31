// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum SuffixTypeEnum {
  @JsonValue('txt')
  txt('txt'),

  /// The name has been replaced because it contains a keyword. Original name: `json`.
  @JsonValue('json')
  valueJson('json'),
  @JsonValue('yaml')
  yaml('yaml'),
  @JsonValue('conf')
  conf('conf'),
  @JsonValue('list')
  list('list'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const SuffixTypeEnum(this.json);

  factory SuffixTypeEnum.fromJson(String json) =>
      values.firstWhere((e) => e.json == json, orElse: () => $unknown);

  final String? json;

  @override
  String toString() => json ?? super.toString();

  /// Returns all defined enum values excluding the $unknown value.
  static List<SuffixTypeEnum> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
