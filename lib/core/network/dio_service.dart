import 'package:dio/dio.dart';
import 'package:teba_haber_v2/core/network/api_constant.dart';

class DioService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstant.apiUrl));
  static final Dio _dioAuth = Dio(BaseOptions(baseUrl: ApiConstant.authUrl));

  // TODO_interceptors

  DioService._();

  static Dio get dio => _dio;

  static Dio get dioAuth => _dioAuth;
}
