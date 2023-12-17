import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:teba_haber_v2/core/model/response_model.dart';

import 'package:teba_haber_v2/core/network/cache_manager.dart';
import 'package:teba_haber_v2/core/network/dio_exception.dart';
import 'package:teba_haber_v2/core/network/dio_service.dart';
import 'package:teba_haber_v2/providers/articles/article_model.dart';

class IDataManager extends ChangeNotifier with CacheManger {
  final Dio _dio = DioService.dio;

  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;
  bool listGetLoading = false;

  void _changeLoading() {
    listGetLoading = !listGetLoading;
    notifyListeners();
  }

  // login handler
  Future<ResponseModel?> getArticles(String? categoryId) async {
    // respond
    try {
      _changeLoading();
      // request
      String url = categoryId != null
          ? "/private_articles/$categoryId.json"
          : '/public_articles.json';

      Response response = await _dio.get(
        url,
      );

      // response is OK
      if (response.statusCode == 200) {
        List<ArticleModel> dataArticles = (response.data as List)
            .map((x) => ArticleModel.fromJson(x))
            .toList();

        // save provider data
        _articles = dataArticles;
        if (kDebugMode) {
          print(_articles);
        }
      }
      _changeLoading();
      notifyListeners();
      return ResponseModel(message: "Giriş Başarılı", success: true);
    } on DioException catch (e) {
      _changeLoading();
      if (kDebugMode) {
        print(e);
      }
      String errorMessage = DioExceptionHandler.handleError(e);
      return ResponseModel(message: errorMessage, success: false);
      // Exception'ı fırlat
    }
  }
}
