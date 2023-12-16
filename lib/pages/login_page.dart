import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teba_haber_v2/core/ui/elevated_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/svg/teba_logo.svg",
                  width: 200,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Form(
                    child: Wrap(
                      runSpacing: 25,
                      children: [
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Kullanıcı Adı'),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Şifre'),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: EasyButton(
                            height: 45.0,
                            onPressed: () async {
                              if (kDebugMode) {
                                print('click');
                              }
                              await Future.delayed(const Duration(seconds: 2));
                            },
                            child: const Text(
                              'Giriş',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
