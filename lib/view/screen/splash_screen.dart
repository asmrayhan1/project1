import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/view/screen/user_auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _delay();
  }
  
  void _delay() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  
  @override
  Widget build(BuildContext context) { 
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff105866),
      body: Center(child: Container(
          height: H / 8,
          width: W / 1.3,
          child: Image.asset('assets/images/ezy.png'))
      ),
    );
  }
}
