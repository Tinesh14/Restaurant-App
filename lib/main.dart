import 'package:flutter/material.dart';

import 'common/routes.dart';
import 'ui/splash_screen_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: PageRoutes().routes(),
      home: const SplashScreenUi(),
    );
  }
}
