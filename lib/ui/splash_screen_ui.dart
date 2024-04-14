// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../common/routes.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  _SplashScreenUiState createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/splash_screen_animation.json",
            controller: _controller,
            fit: BoxFit.contain,
            onLoaded: (p0) {
              _controller
                ..duration = p0.duration
                ..forward().whenComplete(
                  () => Navigator.popAndPushNamed(
                    context,
                    PageRoutes.bottomNavigation,
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}
