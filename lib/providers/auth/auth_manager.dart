import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:teba_haber_v2/core/model/response_model.dart';

import 'package:teba_haber_v2/core/network/cache_manager.dart';
import 'package:teba_haber_v2/core/network/dio_exception.dart';
import 'package:teba_haber_v2/core/network/dio_service.dart';
import 'package:teba_haber_v2/providers/auth/user_available_category_model.dart';
import 'package:teba_haber_v2/providers/auth/user_model.dart';

class IAuthManager extends ChangeNotifier with CacheManger {
  final Dio _dio = DioService.dioAuth;
  final Dio _dio2 = DioService.dio;

  // User Data
  late UserModel? _user;
  List<AvailableCategoryModel> userAvailableCategories = [];
  bool _isAuth = false;
  // get data
  UserModel? get user => _user;
  bool get isAuth => _isAuth;
  // chekc user
  void logoutHandler() {
    changeAuth();
    _user = null;
    userAvailableCategories = [];
    notifyListeners();
  }

  void changeAuth() {
    _isAuth = !_isAuth;
    removeToken();
    notifyListeners();
  }

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

        // giriş başarılı
        // şimdi kullanıcı kategorilerini set edelim
        await getUserAvailableCategories();

        String? token = data['token'];
        // check response token validate
        if (token!.isNotEmpty) {
          saveToken(data['token']);
        }
        changeAuth();
      }

      notifyListeners();
      return ResponseModel(message: "Giriş Başarılı", success: true);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      String errorMessage = DioExceptionHandler.handleError(e);
      return ResponseModel(message: errorMessage, success: false);
      // Exception'ı fırlat
    }
  }

  Future<void> getUserAvailableCategories() async {
    try {
      Response response = await _dio2.get('/user/availableCategories.json');
      if (response.statusCode == 200) {
        List<AvailableCategoryModel> convertRespondData =
            (response.data as List)
                .map((item) => AvailableCategoryModel.fromJson(item))
                .toList();

        userAvailableCategories = convertRespondData;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}


/* Future<void> getAvailableUserCategory(token) async {
  try {
    Response response = await _dio.get('/user/availableCategories.json');
    if (response.statusCode == 200) {
      List<CategoryModel> coverCategory = (response.data as List).map((x) {
        return CategoryModel.fromJson(x);
      }).toList();
      availableCategory = coverCategory;
      notifyListeners();
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
} */
