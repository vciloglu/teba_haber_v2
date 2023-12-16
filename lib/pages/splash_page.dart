import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teba_haber_v2/providers/auth/auth_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    IAuthManager iAuth = Provider.of<IAuthManager>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        iAuth.loginHandler('kminchelle', '0lelplR');
      }),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text("Home"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text("Login"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/home'),
            child: const Text("Home"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/article',
                arguments: {"id": 345}),
            child: const Text("Article"),
          ),
        ],
      ),
    );
  }
}
