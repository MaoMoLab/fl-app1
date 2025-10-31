// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum SubLinkClientTypeEnum {
  @JsonValue('Mixed')
  mixed('Mixed'),
  @JsonValue('AUTO')
  auto('AUTO'),
  @JsonValue('Clash')
  clash('Clash'),
  @JsonValue('ClashR')
  clashR('ClashR'),
  @JsonValue('Quantumult')
  quantumult('Quantumult'),
  @JsonValue('QuantumultX')
  quantumultX('QuantumultX'),
  @JsonValue('Loon')
  loon('Loon'),
  @JsonValue('Mellow')
  mellow('Mellow'),
  @JsonValue('SIP002')
  sip002('SIP002'),
  @JsonValue('SIP008')
  sip008('SIP008'),
  @JsonValue('SSD')
  ssd('SSD'),
  @JsonValue('SSR')
  ssr('SSR'),
  @JsonValue('Surfboard')
  surfboard('Surfboard'),
  @JsonValue('Surge2')
  surge2('Surge2'),
  @JsonValue('Surge3')
  surge3('Surge3'),
  @JsonValue('Surge4')
  surge4('Surge4'),
  @JsonValue('Trojan')
  trojan('Trojan'),
  @JsonValue('V2Ray')
  v2Ray('V2Ray'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const SubLinkClientTypeEnum(this.json);

  factory SubLinkClientTypeEnum.fromJson(String json) =>
      values.firstWhere((e) => e.json == json, orElse: () => $unknown);

  final String? json;

  @override
  String toString() => json ?? super.toString();

  /// Returns all defined enum values excluding the $unknown value.
  static List<SubLinkClientTypeEnum> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
