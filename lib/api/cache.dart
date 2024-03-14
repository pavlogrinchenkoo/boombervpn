import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/api/locations/dto.dart';
import 'auth/dto.dart';

class Cache {
  Future<void> saveUser(UserRequestModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    final string = jsonEncode(user);
    await prefs.setString('user', string);
  }

  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<UserRequestModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('user');
    if (string == null) return null;
    final user = UserRequestModel.fromJson(jsonDecode(string));
    return user;
  }

  Future<void> saveServer(Server server) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('server');
    final string = jsonEncode(server);
    await prefs.setString('server', string);
  }

  Future<void> removeServer() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('server');
  }

  Future<Server?> getServer() async {
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('server');
    if (string == null) return null;
    final user = Server.fromJson(jsonDecode(string));
    return user;
  }

  Future<void> saveSubscribe(bool subscribe) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('subscribe');
    await prefs.setBool('subscribe', subscribe);
  }

  Future<bool> getSubscribe() async {
    final prefs = await SharedPreferences.getInstance();
    final subscribe = prefs.getBool('subscribe');
    return subscribe ?? false;
  }

  Future<void> saveBlockInternet(bool blockInternet) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('blockInternet');
    await prefs.setBool('blockInternet', blockInternet);
  }

  Future<bool> getBlockInternet() async {
    final prefs = await SharedPreferences.getInstance();
    final blockInternet = prefs.getBool('blockInternet');
    return blockInternet ?? false;
  }

  Future<void> saveConnectVPN(bool connectVPN) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('connectVPN');
    await prefs.setBool('connectVPN', connectVPN);
  }

  Future<bool> getConnectVPN() async {
    final prefs = await SharedPreferences.getInstance();
    final connectVPN = prefs.getBool('connectVPN');
    return connectVPN ?? false;
  }

  Future<void> saveShowNotification(bool showNotification) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('showNotification');
    await prefs.setBool('showNotification', showNotification);
  }

  Future<bool> getShowNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final showNotification = prefs.getBool('showNotification');
    return showNotification ?? false;
  }

  Future<void> saveFirstLaunch(bool firstLaunch) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('firstLaunch');
    await prefs.setBool('firstLaunch', firstLaunch);
  }

  Future<bool> getFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final showNotification = prefs.getBool('firstLaunch');
    return showNotification ?? false;
  }

  Future<void> saveLocation(LatLon location) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('location');
    final string = jsonEncode(location);
    await prefs.setString('location', string);
  }

  Future<MapLatLng> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final stringLocation = prefs.getString('location');
    if (stringLocation == null) return const MapLatLng(1, 1);
    final location = LatLon.fromJson(jsonDecode(stringLocation));
    final latLng = MapLatLng(location.lat, location.lon);
    return latLng;
  }
}
