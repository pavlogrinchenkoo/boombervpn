// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListLocationModel _$ListLocationModelFromJson(Map<String, dynamic> json) =>
    ListLocationModel(
      status: json['status'] as String?,
      freeServers: (json['free_servers'] as List<dynamic>?)
          ?.map((e) => Server.fromJson(e as Map<String, dynamic>))
          .toList(),
      premiumServers: (json['premium_servers'] as List<dynamic>?)
          ?.map((e) => Server.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListLocationModelToJson(ListLocationModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'free_servers': instance.freeServers,
      'premium_servers': instance.premiumServers,
    };

Server _$ServerFromJson(Map<String, dynamic> json) => Server(
      type: json['type'] as String?,
      pingHost: json['ping_host'] as String?,
      flag: json['flag'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
      'type': instance.type,
      'ping_host': instance.pingHost,
      'flag': instance.flag,
      'code': instance.code,
    };

ConnectResponseModel _$ConnectResponseModelFromJson(
        Map<String, dynamic> json) =>
    ConnectResponseModel(
      bearer: json['bearer'] as String?,
      userId: json['user_id'] as String?,
      location: json['location'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ConnectResponseModelToJson(
        ConnectResponseModel instance) =>
    <String, dynamic>{
      'bearer': instance.bearer,
      'user_id': instance.userId,
      'location': instance.location,
      'type': instance.type,
    };

ConnectRequestModel _$ConnectRequestModelFromJson(Map<String, dynamic> json) =>
    ConnectRequestModel(
      status: json['status'] as String,
      ovpn: json['ovpn'] as String,
      encoding: json['encoding'] as String,
    );

Map<String, dynamic> _$ConnectRequestModelToJson(
        ConnectRequestModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'ovpn': instance.ovpn,
      'encoding': instance.encoding,
    };
