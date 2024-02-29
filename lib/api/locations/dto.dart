import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';
@JsonSerializable()
class ListLocationModel {
  String? status;
  @JsonKey(name: 'free_servers')
  List<Server>? freeServers;
  @JsonKey(name: 'premium_servers')
  List<Server>? premiumServers;

  ListLocationModel({
     this.status,
     this.freeServers,
     this.premiumServers,
  });

  factory ListLocationModel.fromJson(Map<String, dynamic> json) =>
      _$ListLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListLocationModelToJson(this);
}


@JsonSerializable()
class Server {
  String? type;
  @JsonKey(name: 'ping_host')
  String? pingHost;
  String? flag;
  String? code;
  double? latitude;
  double? longitude;

  Server({
     this.type,
     this.pingHost,
     this.flag,
     this.code,
  });

  factory Server.fromJson(Map<String, dynamic> json) =>
      _$ServerFromJson(json);

  Map<String, dynamic> toJson() => _$ServerToJson(this);
}


@JsonSerializable()
class ConnectResponseModel {
  final String? bearer;
  @JsonKey(name: 'user_id')
  final String? userId;
  final String? location;
  final String? type;

  ConnectResponseModel({this.bearer, this.userId, this.location, this.type});

  factory ConnectResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectResponseModelToJson(this);
}

@JsonSerializable()
class ConnectRequestModel {
  String status;
  String ovpn;
  String encoding;

  ConnectRequestModel({
    required this.status,
    required this.ovpn,
    required this.encoding,
  });

  factory ConnectRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectRequestModelToJson(this);
}

@JsonSerializable()
class LatLon{
  final double lat;
  final double lon;

  LatLon({required this.lat, required this.lon});

  factory LatLon.fromJson(Map<String, dynamic> json) =>
      _$LatLonFromJson(json);

  Map<String, dynamic> toJson() => _$LatLonToJson(this);
}

