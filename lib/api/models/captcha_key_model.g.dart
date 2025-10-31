// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha_key_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaKeyModel _$CaptchaKeyModelFromJson(Map<String, dynamic> json) =>
    CaptchaKeyModel(
      message: json['message'] as String,
      captchaKeyType: CaptchaKeyTypeEnum.fromJson(
        json['captcha_key_type'] as String,
      ),
      tiago2CapKeyId: json['tiago2_cap_key_id'] as String,
      captchaKey: json['captcha_key'] as String?,
      isSuccess: json['is_success'] as bool? ?? false,
    );

Map<String, dynamic> _$CaptchaKeyModelToJson(CaptchaKeyModel instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'message': instance.message,
      'captcha_key': instance.captchaKey,
      'captcha_key_type': _$CaptchaKeyTypeEnumEnumMap[instance.captchaKeyType]!,
      'tiago2_cap_key_id': instance.tiago2CapKeyId,
    };

const _$CaptchaKeyTypeEnumEnumMap = {
  CaptchaKeyTypeEnum.forgotPassword: 'forgot_password',
  CaptchaKeyTypeEnum.register: 'register',
  CaptchaKeyTypeEnum.login: 'login',
  CaptchaKeyTypeEnum.test: 'test',
  CaptchaKeyTypeEnum.$unknown: r'$unknown',
};
