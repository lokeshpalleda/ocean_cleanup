import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_clean/flutter_frontend/login_credentials/auth_screen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/animation.json', height: 220),
          const SizedBox(height: 20),
          const Text(
            'Ocean Cleanup',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: Color.fromARGB(255, 153, 212, 225),
              fontStyle: FontStyle.normal,
            
            ),
          ),
        ],
      ),
      duration: 3500,
      splashIconSize: 300,
      backgroundColor: Colors.white,
      nextScreen: const AuthScreen(),
      //splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(milliseconds: 1000),
    );
  }
}