import 'package:dio/dio.dart';
import 'package:vpn/api/cache.dart';
import 'dto.dart';

class AuthApi {
  Dio dio = Dio();
  Cache cache = Cache();

  Future<void> signUp(SignUpModel data) async {
    try {
      const url = 'https://bombervip.com/api/user/signupViaEmail';
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
        print('Success: ${response.data['msg']}');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<LoginResponseModel> login(SignUpModel data) async {
    try {
      const url = 'https://bombervip.com/api/user/signinViaEmail';
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
        final json = LoginResponseModel.fromJson(response.data);
        await cache.saveUser(UserRequestModel(
          bearer: json.bearer,
          userId: json.userId,
        ));
        return json;
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<String?> resetPassword(SignUpModel data) async {

      const url = 'https://bombervip.com/api/user/sendPasswordResetLink';
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
        print('Success: ${response.data['msg']}');
        return response.data['msg'];
      }

  }

  Future<UserResponseModel> getUser() async {
    try {
      const url = 'https://bombervip.com/api/sessionInfo';
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
        final user = UserResponseModel.fromJson(response.data);
        return user;
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
