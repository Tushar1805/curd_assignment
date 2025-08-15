// ignore_for_file: use_build_context_synchronously

import 'dart:async'; // ⬅️ for Timer
import 'package:curd_assignment/resources/app_colors.dart';
import 'package:curd_assignment/resources/app_images.dart';
import 'package:curd_assignment/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// ⬇️ Observe lifecycle to know when user returns from Settings
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 3), () {
      context.pushReplacementNamed(setLanguageScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Theme.of(context).brightness == Brightness.light
            ? splashLightBackground
            : darkBackground,
        child: Center(
          child: SizedBox(
            width: size.width * 0.6,
            child: Image.asset(
              appLogoIcon,
              height: size.width * 0.6,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
