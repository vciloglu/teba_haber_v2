import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teba_haber_v2/providers/auth/auth_manager.dart';
import 'package:teba_haber_v2/routes/routes_generator.dart';

void main() {
  runApp(const TebaMainApp());
}

class TebaMainApp extends StatelessWidget {
  const TebaMainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => IAuthManager())],
      child: MaterialApp(
        title: 'Teba Haber',
        initialRoute: '/login',
        onGenerateRoute: RoutesGenerator.generateRoute,
        theme: ThemeData(
          useMaterial3: true,
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
        ),
      ),
    );
  }
}
