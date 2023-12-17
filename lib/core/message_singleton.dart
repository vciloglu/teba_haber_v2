import 'package:flutter/material.dart';

class MessengerSingleton {
  // Statik örnek değişkeni
  static MessengerSingleton? _instance;

  // Özel kurucu fonksiyon
  MessengerSingleton._();

  // Fabrika kurucu fonksiyon
  factory MessengerSingleton() {
    // Eğer örnek değişkeni null ise, yeni bir örnek yarat
    _instance ??= MessengerSingleton._();
    // Örnek değişkenini döndür
    return _instance!;
  }

  // Error methodu
  void error(BuildContext context, String text) {
    // ScaffoldMessenger nesnesini al

    // Kırmızı renkli bir SnackBar göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
        duration: const Duration(days: 1),
      ),
    );
  }

  // Success methodu
  void success(BuildContext context, String text) {
    // Yeşil renkli bir SnackBar göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Warning methodu
  void warning(BuildContext context, String text) {
    // ScaffoldMessenger nesnesini al
    // Sarı renkli bir SnackBar göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.yellow,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
