import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/view/screen/community.dart';
import 'package:project1/view/screen/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
late SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  runApp(ProviderScope(child: const MyApp()));
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