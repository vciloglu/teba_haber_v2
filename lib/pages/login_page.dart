import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:teba_haber_v2/core/message_singleton.dart';
import 'package:teba_haber_v2/core/model/response_model.dart';
import 'package:teba_haber_v2/core/ui/elevated_loading_button.dart';
import 'package:teba_haber_v2/core/ui/password_field.dart';
import 'package:teba_haber_v2/providers/auth/auth_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  MessengerSingleton showMessage = MessengerSingleton();

  Future<void> loginHandler(String username, String password) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    // auth provider
    IAuthManager authManager = context.read<IAuthManager>();

    ResponseModel? response =
        await authManager.loginHandler(username, password);

    print(response);
    if (response != null && response.success) {
      // giriş başarılı
      // giriş başarılı ise drawer kategorileri zaten authmanager içerisinde yapılacaktır. token zaten set ediytolyor
      goToHomepage();
      return;
    }

    showMessageHandler(response!.success, response.message);
    return;
  }

  goToHomepage() {
    Navigator.pushNamed(context, '/home');
  }

  showMessageHandler(bool success, String message) {
    if (success == false) {
      showMessage.error(context, message);
    } else {
      showMessage.success(context, message);
    }
  }

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
                    key: formKey,
                    child: Wrap(
                      runSpacing: 25,
                      children: [
                        TextFormField(
                          controller: controllerUsername,
                          validator: (value) =>
                              value!.isEmpty ? 'Not found data' : null,
                          decoration: const InputDecoration(
                            labelText: 'Kullanıcı Adı',
                          ),
                        ),
                        PasswordFormField(
                          controller: controllerPassword,
                          validator: (value) =>
                              value!.isEmpty ? 'Not found data' : null,
                          labelText: 'Şifre',
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: EasyButton(
                            height: 45.0,
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                // hide keeyboard
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                // call login request
                                await loginHandler(
                                  controllerUsername.text.trim(),
                                  controllerPassword.text.trim(),
                                );
                              }
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
