import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:teba_haber_v2/core/network/cache_manager.dart';
import 'package:teba_haber_v2/core/network/dio_exception.dart';
import 'package:teba_haber_v2/core/network/dio_service.dart';
import 'package:teba_haber_v2/providers/auth/user_model.dart';

class IAuthManager extends ChangeNotifier with CacheManger {
  final Dio _dio = DioService.dioAuth;

  // User Data
  late UserModel? _user;

  // get data
  UserModel? get user => _user;

  // login handler
  Future<ResponseModel?> loginHandler(String username, String password) async {
    // respond
    try {
      Response response = await _dio.post(
        '/auth/login',
        data: json.encode(
          {'username': username, "password": password},
        ),
      );

      // response is OK
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;

        // save provider data
        _user = UserModel.fromJson(data);
        String? token = data['token'];

        // check response token validate
        if (token!.isNotEmpty) {
          saveToken(data['token']);
        }
      }

      notifyListeners();
      return ResponseModel(message: "Giriş Başarılı", success: true);
    } on DioException catch (e) {
      print(e);
      String errorMessage = DioExceptionHandler.handleError(e);
      return ResponseModel(message: errorMessage, success: false);
      // Exception'ı fırlat
    }
  }
}

class ResponseModel {
  String message;
  bool success;
  ResponseModel({
    required this.message,
    required this.success,
  });
}
