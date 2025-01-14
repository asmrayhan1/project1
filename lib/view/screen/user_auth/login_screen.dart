import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/components/custom_textfield.dart';
import 'package:project1/components/password.dart';
import 'package:project1/controller/login/login_controller.dart';
import 'package:project1/main.dart';
import 'package:project1/utils/toast/toast_util.dart';
import 'package:project1/view/screen/news_feed.dart';
import 'package:project1/view/screen/user_auth/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isChecked = false;
  String _email = ""; bool _isEmail = false;
  String _password = ""; bool _isPassword = false;

  // This function will be passed to Password widget to receive updated password
  void _onEmail(String email, bool status) {
    setState(() {
      _email = email;
      _isEmail= status;
    });
  }

  void _onPassword(String password, bool status) {
    setState(() {
      _password = password;
      _isPassword = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff105866),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              //height: H / 4,
              width: W,
              child: Image.asset('assets/images/background2.png'),
            )
          ),
          Positioned(
              top: H / 7,
              left: 0,
              right: 0,
              child: Container(
                //height: H / 4,
                width: W,
                child: Image.asset('assets/images/background1.png'),
              )
          ),
          Positioned(
              top: H / 7,
              left: 0,
              right: 0,
              child: Container(
                height: H / 9,
                child: Image.asset('assets/images/ezy.png'),
              )
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: H / 1.6,
                width: W,
                decoration: BoxDecoration(
                  color: Color(0xff105866),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  border: Border(
                     top: BorderSide(
                       color: Colors.black38,
                       width: 5,
                     ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("Sign In", style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w800),)),
                        SizedBox(height: 20),
                        Text("Email", style: TextStyle(fontSize: 25, color: Colors.white60)),
                        SizedBox(height: 7),
                        CustomTextfield(hintText: "Enter Your Email", value: 2, onValueChanged: _onEmail),
                        SizedBox(height: 25),
                        Text("Password", style: TextStyle(fontSize: 25, color: Colors.white60),),
                        SizedBox(height: 7),
                        Password(password: "Enter Your Password", onPasswordChanged: _onPassword),
                        SizedBox(height: 17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _isChecked = !_isChecked;
                                    });
                                  },
                                  child: _isChecked? Icon(Icons.check_box, color: Colors.white, size: 22) : Icon(Icons.check_box_outline_blank, color: Colors.white70, size: 22),
                                ),
                                SizedBox(width: 10),
                                Text("Remember me", style: TextStyle(color: Colors.white70, fontSize: 20))
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewsFeed()));
                              },
                              child: Text("Forgot Password?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white70))
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        GestureDetector(
                          onTap: () async {
                            if (_isPassword && _isEmail){
                              String? serverMessage = await ref.read(loginProvider.notifier).login(email: _email, password: _password);
                              if (serverMessage != null){
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                if (_isChecked){
                                  prefs.setString('token', serverMessage);
                                  setState(() {
                                    token = serverMessage;
                                  });
                                };
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewsFeed()));
                                print("Login button working");
                                ToastUtil.showToast(context: context, message: "Login Successfully.");
                              } else {
                                ToastUtil.showToast(context: context, message: "Error Found. Try Again!", isWarning: true);
                              }
                            } else {
                              ToastUtil.showToast(context: context, message: "Invalid Input.", isWarning: true);
                            }
                          },
                          child: Container(
                            height: 60,
                            width: W,
                            decoration: BoxDecoration(
                              color: Color(0xffe8f54a),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("Login", style: TextStyle(color: Color(0xff105866), fontSize: 25, fontWeight: FontWeight.bold),)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Don't have an account?", style: TextStyle(color: Colors.white70, fontSize: 17)),
                            SizedBox(width: 10),
                            GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                                },
                                child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17))
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}