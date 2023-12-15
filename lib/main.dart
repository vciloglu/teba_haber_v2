import 'package:flutter/material.dart';
import 'package:teba_haber_v2/routes/routes_generator.dart';

void main() {
  runApp(const TebaMainApp());
}

class TebaMainApp extends StatelessWidget {
  const TebaMainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teba Haber',
      initialRoute: '/',
      onGenerateRoute: RoutesGenerator.generateRoute,
      // routes: {
      //   "/": (context) => const SplashPage(),
      //   "/home": (context) => const HomePage(),
      //   "/article": (context) => const ArticlePage(),
      //   "/login": (context) => const LoginPage(),
      // },
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
