// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:ecopos/util/auth_manager.dart';
import 'package:ecopos/util/dio.dart';
import 'package:ecopos/util/exception.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(String Email, String Password, String Confirmpassword, String name);
  Future<String> login(String Email, String Password);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio _dio = DioProvider.createDioWithoutHeader();

  @override
  Future<void> register(String Email, String Password, String Confirmpassword, String name) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'email': Email,
        'username': name,
        'password': Password,
        'passwordConfirm': Confirmpassword,
      });
      if (response.statusCode == 200) {
        await login(Email, Password); // tambahkan await biar tunggu login selesai
      }
    } on DioError catch (ex) {
      throw ApiException(ex.response?.data['message'] ?? 'Unknown error', ex.response);
    } catch (ex) {
      throw ApiException('Unknown error', null);
    }
  }

  @override
  Future<String> login(String Email, String Password) async {
    try {
      final response = await _dio.post('collections/users/auth-with-password', data: {
        'identity': Email,
        'password': Password,
      });
      if (response.statusCode == 200) {
        AuthManager.saveId(response.data?['record']['id']);
        AuthManager.saveToken(response.data?['token']);
        return response.data?['token'] ?? '';
      }
    } on DioError catch (ex) {
      throw ApiException(ex.response?.data['message'] ?? 'Unknown error', ex.response);
    } catch (ex) {
      throw ApiException('Unknown error', null);
    }
    return '';
  }
}
