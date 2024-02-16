import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/api/locations/dto.dart';
import 'auth/dto.dart';

class Cache{
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
}