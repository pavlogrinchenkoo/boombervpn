import 'package:dio/dio.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/api/locations/dto.dart';

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

  Future<ConnectRequestModel> connectLocation(
      ConnectResponseModel data) async {
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
