import 'dart:async';
import 'package:flutter/material.dart';
import '/screens/home/home_screen.dart';
import '/constants/app_colors.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    controller.forward();

    // بعد 3 ثواني يروح للهوم
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.darkBlue , // Dark Blue
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: Text(
              "Contact",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color:  AppColors.gold, // Gold
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}