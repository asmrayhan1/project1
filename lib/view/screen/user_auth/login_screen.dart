import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/components/custom_textfield.dart';
import 'package:project1/components/password.dart';
import 'package:project1/utils/toast/toast_util.dart';
import 'package:project1/view/screen/news_feed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = ""; bool _isEmail = false;
  String _password = ""; bool _isPassword = false;

  // This function will be passed to Password widget to receive updated password
  void _onEmail(String email, bool status) {
    setState(() {
      _email = email;
      _isEmail= status;
    });
  }

  // This function will be passed to Password widget to receive updated password
  void _onPassword(String password, bool status) {
    setState(() {
      _password = password;
      _isPassword = status;
    });
  }

  bool _isChecked = false;
  void _toggleCheckbox(bool? newValue){
    setState(() {
      _isChecked = newValue!;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text("Sign In", style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w800),)),
                      SizedBox(height: 20),
                      Text("Email", style: TextStyle(fontSize: 25, color: Colors.white60)),
                      SizedBox(height: 7),
                      CustomTextfield(hintText: "Enter Your Email", value: 2, onValueChanged: _onEmail),
                      SizedBox(height: 30),
                      Text("Password", style: TextStyle(fontSize: 25, color: Colors.white60),),
                      SizedBox(height: 7),
                      Password(password: "Enter Your Password", onPasswordChanged: _onPassword),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1.3, // Scale the checkbox to 1.3 times its original size
                            child: Checkbox(
                              activeColor: Colors.white, // Color of the checkbox when checked
                              checkColor: Colors.black,  // Color of the checkmark
                              value: _isChecked,
                              onChanged: _toggleCheckbox,
                              side: BorderSide(
                                color: Colors.white60, // Custom border color
                                width: 2, // Border thickness
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text("Remember me", style: TextStyle(color: Colors.white, fontSize: 25),)
                        ],
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: (){
                          if (_isPassword && _isEmail){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewsFeed()));
                            print("Login button working");
                            ToastUtil.showToast(context: context, message: "Login Successfully.");
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
                      )
                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}