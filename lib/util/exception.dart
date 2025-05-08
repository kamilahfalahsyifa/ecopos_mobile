import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? code;
  String message;
  Response<dynamic>? response;

  ApiException(this.message, this.response) {
    code = response?.statusCode;

    if (code != 400) return;

    // Modifikasi pesan berdasarkan response
    if (message == 'Failed to authenticate.') {
      this.message = 'Password or username is incorrect';
    }

    if (message == 'Failed to create record.') {
      final data = response?.data['data'];
      final usernameError = data?['username']?['message'];
      final emailError = data?['email']?['message'];

      if (usernameError == 'The username is invalid or already in use.') {
        this.message = 'Username is already in use';
      }

      if (emailError == 'The email is invalid or already in use.') {
        this.message = 'Email is already in use';
      }
    }
  }

  @override
  String toString() => 'ApiException: $message (code: $code)';
}
