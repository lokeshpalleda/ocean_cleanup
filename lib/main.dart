import 'package:flutter/material.dart';
import 'package:ocean_clean/splash/splash_screen.dart';

void main() async {
  
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Splashscreen(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}