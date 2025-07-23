import 'package:flutter/material.dart';
import 'package:ocean_clean/spalsh_screen.dart';
//import 'firebase_options.dart';
//import 'package:firebase_core/firebase_core.dart';

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