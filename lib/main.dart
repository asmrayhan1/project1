import 'package:flutter/material.dart';
import 'package:project1/view/screen/login_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:project1/view/screen/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset('assets/images/ezy.png'),
          nextScreen: OnBoardingScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color(0xff105866)
      )
    );
  }
}