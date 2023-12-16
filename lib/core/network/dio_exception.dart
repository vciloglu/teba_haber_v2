import 'package:dio/dio.dart';

// DioExceptionHandler sınıfı, DioException tipinde bir parametre alır ve
// hata durumuna göre bir mesaj döndürür
class DioExceptionHandler {
  // DioException tipinde bir parametre alan ve String tipinde bir değer döndüren
  // handleError adında bir statik fonksiyon
  static String handleError(DioException error) {
    // Hata tipini bir değişkene atayalım

    // Hata mesajını bir değişkene atayalım
    String errorMessage = "";

    // Hata tipine göre hata mesajını belirleyelim
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = "Bağlantı zaman aşımı";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Gönderme zaman aşımı";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Alma zaman aşımı";
        break;
      case DioExceptionType.badResponse:
        errorMessage = "Geçersiz yanıt alındı. [${error.response?.data[0]}]";
        break;
      case DioExceptionType.cancel:
        // Bu durumlarda, _errorMessages map'inden hata tipine karşılık gelen mesajı alalım
        errorMessage = "İptal edildi";
        break;
      default:
        // Bu durumda, hata mesajını boş bırakalım
        errorMessage = "${error.message}";
        break;
    }

    // Hata mesajını döndürelim
    return errorMessage;
  }
}
