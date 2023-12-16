import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(88, 40),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Giriş'),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
