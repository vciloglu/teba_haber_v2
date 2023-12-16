import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teba_haber_v2/core/network/cache_manager.dart';
import 'package:teba_haber_v2/providers/articles/data_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with CacheManger {
  bool auth = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await respondGetArticles();
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

  void goToHome() {
    Navigator.pushNamed(context, '/home');
  }
}
