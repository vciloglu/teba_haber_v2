import 'package:flutter/material.dart';
import 'package:teba_haber_v2/pages/article_page.dart';
import 'package:teba_haber_v2/pages/home_page.dart';
import 'package:teba_haber_v2/pages/login_page.dart';
import 'package:teba_haber_v2/pages/splash_page.dart';
import 'package:teba_haber_v2/providers/articles/article_model.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    WidgetBuilder builder;
    switch (settings.name) {
      case "/":
        builder = (_) => const SplashPage();

        break;
      case "/home":
        builder = (_) => const HomePage();
        break;
      case "/article":
        if (args != null) {
          final argsMap = args as Map<String, dynamic>;
          builder =
              (_) => ArticlePage(article: argsMap['article'] as ArticleModel);
        } else {
          builder = _errorRoute();
        }
        break;
      case "/login":
        builder = (_) => const LoginPage();
        break;

      default:
        builder = _errorRoute();
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
      fullscreenDialog: true,
    );
  }

  static WidgetBuilder _errorRoute() {
    return (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    };
  }
}
