import 'package:flutter/material.dart';
import 'package:ocean_clean/screen.dart';
//import 'firebase_options.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized(); 
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform, 
  // );

  runApp(const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}