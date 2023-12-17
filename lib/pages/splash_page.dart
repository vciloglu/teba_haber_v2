import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teba_haber_v2/core/network/cache_manager.dart';
import 'package:teba_haber_v2/providers/articles/data_manager.dart';
import 'package:teba_haber_v2/providers/auth/auth_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with CacheManger {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await respondGetArticles();
      await Future.delayed(const Duration(seconds: 1));
      bool isAuth = await hasToken();
      if (isAuth) {
        await respondAvailableCategories();
      }
      goToHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<String?> checkToken() async {
    String? token;
    token = await getToken();
    return token;
    // goToHome();
  }

  Future<void> respondGetArticles() async {
    await context.read<IDataManager>().getArticles(null);
    setState(() {});
  }

  Future<void> respondAvailableCategories() async {
    await context.read<IAuthManager>().getUserAvailableCategories();
    setState(() {});
  }

  void goToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
