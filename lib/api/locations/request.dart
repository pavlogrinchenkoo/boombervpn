import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:http/http.dart' as http;

class LocationsApi {
  Dio dio = Dio();
  Cache cache = Cache();

  Future<ListLocationModel> getListLocation() async {
    try {
      const url = 'https://bombervip.com/api/servers';
      final data = await cache.getUser();
      Response response = await dio.post(
        url,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      if (response.data['status'] == 'err') {
        print('Error: ${response.data['msg']}');
        throw Exception(response.data['msg']);
      } else {
        final json = ListLocationModel.fromJson(response.data);
        return json;
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<ConnectRequestModel> connectLocation(ConnectResponseModel data) async {
    try {
      const url = 'https://bombervip.com/api/connect';
      Response response = await dio.post(
        url,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      if (response.data['status'] == 'err') {
        print('Error: ${response.data['msg']}');
        throw Exception(response.data['msg']);
      } else {
        final json = ConnectRequestModel.fromJson(response.data);
        return json;
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<String> apiRequest(Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/x-www-form-urlencoded');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  Future<String> sendData(Map data) async {
    final urlParse = Uri.parse(url);
    http.Response response = await http.post(urlParse,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data));
    if (response.statusCode == 200)
      return (response.body);
    else
      return 'No Data';
  }

  Future<String> getData() async {
    final urlParse = Uri.parse(url);
    http.Response response = await http.post(urlParse,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'});
    if (response.statusCode == 200)
      return (response.body);
    else
      return 'No Data';
  }
}
