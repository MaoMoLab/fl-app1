// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum VpnTypeEnum {
  @JsonValue('placeholder')
  placeholder('placeholder'),
  @JsonValue('http')
  http('http'),
  @JsonValue('socks5')
  socks5('socks5'),
  @JsonValue('vless')
  vless('vless'),
  @JsonValue('vmess')
  vmess('vmess'),
  @JsonValue('trojan')
  trojan('trojan'),
  @JsonValue('tuic')
  tuic('tuic'),
  @JsonValue('juicity')
  juicity('juicity'),
  @JsonValue('naive')
  naive('naive'),
  @JsonValue('shadowsocks')
  shadowsocks('shadowsocks'),
  @JsonValue('shadowsocksr')
  shadowsocksr('shadowsocksr'),
  @JsonValue('hysteria2')
  hysteria2('hysteria2'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const VpnTypeEnum(this.json);

  factory VpnTypeEnum.fromJson(String json) =>
      values.firstWhere((e) => e.json == json, orElse: () => $unknown);

  final String? json;

  @override
  String toString() => json ?? super.toString();

  /// Returns all defined enum values excluding the $unknown value.
  static List<VpnTypeEnum> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
