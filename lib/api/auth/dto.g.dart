// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      lang: json['lang'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      passwordReEntrered: json['password_re_entrered'] as String?,
      gRecaptchaResponse: json['g-recaptcha-response'] as String?,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'lang': instance.lang,
      'email': instance.email,
      'password': instance.password,
      'password_re_entrered': instance.passwordReEntrered,
      'g-recaptcha-response': instance.gRecaptchaResponse,
    };

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      status: json['status'] as String?,
      msg: json['msg'] as String?,
      bearer: json['bearer'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'bearer': instance.bearer,
      'user_id': instance.userId,
    };

UserRequestModel _$UserRequestModelFromJson(Map<String, dynamic> json) =>
    UserRequestModel(
      bearer: json['bearer'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$UserRequestModelToJson(UserRequestModel instance) =>
    <String, dynamic>{
      'bearer': instance.bearer,
      'user_id': instance.userId,
    };

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) =>
    UserResponseModel(
      status: json['status'] as String?,
      session: json['session'] == null
          ? null
          : Session.fromJson(json['session'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      ip: json['ip'] as String?,
      geoInfo: json['geo_info'] == null
          ? null
          : GeoInfo.fromJson(json['geo_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'session': instance.session,
      'user': instance.user,
      'ip': instance.ip,
      'geo_info': instance.geoInfo,
    };

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      bearer: json['bearer'] as String?,
      started: json['started'] as String?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'bearer': instance.bearer,
      'started': instance.started,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirmed: json['confirmed'] as String?,
      admin: json['admin'] as String?,
      submitToken: json['submit_token'] as String?,
      blocked: json['blocked'] as String?,
      accountType: json['account_type'] as String?,
      time: json['time'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      authVia: json['auth_via'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'confirmed': instance.confirmed,
      'admin': instance.admin,
      'submit_token': instance.submitToken,
      'blocked': instance.blocked,
      'account_type': instance.accountType,
      'time': instance.time,
      'date': instance.date?.toIso8601String(),
      'auth_via': instance.authVia,
    };

GeoInfo _$GeoInfoFromJson(Map<String, dynamic> json) => GeoInfo(
      ip: json['ip'] as String?,
      countryName: json['country_name'] as String?,
      stateProv: json['state_prov'] as String?,
      isp: json['isp'] as String?,
    );

Map<String, dynamic> _$GeoInfoToJson(GeoInfo instance) => <String, dynamic>{
      'ip': instance.ip,
      'country_name': instance.countryName,
      'state_prov': instance.stateProv,
      'isp': instance.isp,
    };
