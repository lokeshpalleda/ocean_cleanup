import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_clean/flutter_frontend/login_credentials/auth_screen.dart';
import 'package:ocean_clean/flutter_frontend/user_side/pages/navigatoin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});
  Future<Widget> _getNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      return const Screen(); // Main screen
    } else {
      return const AuthScreen(); // Login/Signup
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getNextScreen(),
      builder: (context, snapshot) {
        Widget nextScreen = const AuthScreen(); // default
        if (snapshot.connectionState == ConnectionState.done) {
          nextScreen = snapshot.data!;
        }

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
          nextScreen: nextScreen,
          animationDuration: const Duration(milliseconds: 1000),
        );
      },
    );
  }
}