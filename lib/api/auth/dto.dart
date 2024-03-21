import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class SignUpModel {
  final String? lang;
  final String? email;
  final String? password;
  @JsonKey(name: 'password_re_entrered')
  final String? passwordReEntrered;
  @JsonKey(name: 'g-recaptcha-response')
  final String? gRecaptchaResponse;

  SignUpModel(
      {this.lang,
      this.email,
      this.password,
      this.passwordReEntrered,
      this.gRecaptchaResponse});

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}

@JsonSerializable()
class LoginResponseModel {
  final String? status;
  final String? msg;
  final String? bearer;
  @JsonKey(name: 'user_id')
  final String? userId;

  LoginResponseModel({
    required this.status,
    required this.msg,
    required this.bearer,
    required this.userId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class UserRequestModel {
  final String? bearer;
  @JsonKey(name: 'user_id')
  final String? userId;

  UserRequestModel({
    this.bearer,
    this.userId,
  });

  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestModelToJson(this);
}

@JsonSerializable()
class UserResponseModel {
  final String? status;
  final Session? session;
  final User? user;
  final String? ip;
  @JsonKey(name: 'geo_info')
  final GeoInfo? geoInfo;

  UserResponseModel({
    this.status,
    this.session,
    this.user,
    this.ip,
    this.geoInfo,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}

@JsonSerializable()
class Session {
  final String? bearer;
  final String? started;

  Session({
    this.bearer,
    this.started,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable()
class User {
  final String? id;
  final String? email;
  final String? password;
  final String? confirmed;
  final String? admin;
  @JsonKey(name: 'submit_token')
  final String? submitToken;
  final String? blocked;
  @JsonKey(name: 'account_type')
  final String? accountType;
  final String? time;
  final DateTime? date;
  @JsonKey(name: 'auth_via')
  final String? authVia;

  User({
    this.id,
    this.email,
    this.password,
    this.confirmed,
    this.admin,
    this.submitToken,
    this.blocked,
    this.accountType,
    this.time,
    this.date,
    this.authVia,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class GeoInfo {
  final String? ip;
  @JsonKey(name: 'country_name')
  final String? countryName;
  @JsonKey(name: 'state_prov')
  final String? stateProv;
  @JsonKey(name: 'isp')
  final String? isp;

  GeoInfo({this.ip, this.countryName, this.stateProv, this.isp});

  factory GeoInfo.fromJson(Map<String, dynamic> json) =>
      _$GeoInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoInfoToJson(this);
}
