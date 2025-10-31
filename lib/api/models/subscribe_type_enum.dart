// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum SubscribeTypeEnum {
  @JsonValue('ss')
  ss('ss'),
  @JsonValue('ssa')
  ssa('ssa'),
  @JsonValue('ssd')
  ssd('ssd'),
  @JsonValue('ssr')
  ssr('ssr'),
  @JsonValue('sub')
  sub('sub'),
  @JsonValue('clash')
  clash('clash'),
  @JsonValue('surge')
  surge('surge'),
  @JsonValue('clashr')
  clashr('clashr'),
  @JsonValue('v2rayn')
  v2rayn('v2rayn'),
  @JsonValue('kitsunebi')
  kitsunebi('kitsunebi'),
  @JsonValue('surfboard')
  surfboard('surfboard'),
  @JsonValue('quantumult')
  quantumult('quantumult'),
  @JsonValue('quantumultx')
  quantumultx('quantumultx'),
  @JsonValue('shadowrocket')
  shadowrocket('shadowrocket'),
  @JsonValue('clash_provider')
  clashProvider('clash_provider'),
  @JsonValue('clashr_provider')
  clashrProvider('clashr_provider'),
  @JsonValue('quantumult_sub')
  quantumultSub('quantumult_sub'),
  @JsonValue('quantumult_conf')
  quantumultConf('quantumult_conf'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const SubscribeTypeEnum(this.json);

  factory SubscribeTypeEnum.fromJson(String json) =>
      values.firstWhere((e) => e.json == json, orElse: () => $unknown);

  final String? json;

  @override
  String toString() => json ?? super.toString();

  /// Returns all defined enum values excluding the $unknown value.
  static List<SubscribeTypeEnum> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
