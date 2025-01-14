import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/components/custom_textfield.dart';
import 'package:project1/components/password.dart';
import 'package:project1/utils/toast/toast_util.dart';
import 'package:project1/view/screen/news_feed.dart';
import 'package:project1/view/screen/user_auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name = ""; bool _isName = false;
  String _email = ""; bool _isEmail = false;
  String _phone = ""; bool _isPhone = false;
  String _password = ""; bool _isPassword = false;
  String _confirmPassword = ""; bool _isConfirmPassword = false;

  // This function will be passed to Password widget to receive updated password
  void _onName(String name, bool status) {
    setState(() {
      _name = name;
      _isName = status;
    });
  }

  void _onEmail(String email, bool status) {
    setState(() {
      _email = email;
      _isEmail = status;
    });
  }

  void _onPhone(String phone, bool status) {
    setState(() {
      _phone = phone;
      _isPhone = status;
    });
  }

  void _onPassword(String password,bool status) {
    setState(() {
      _password = password;
      _isPassword = status;
    });
  }

  void _onConfirmPassword(String password, bool status) {
    setState(() {
      _confirmPassword = password;
      _isConfirmPassword = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff105866),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff105866),
        title: Text("Create an Account", style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Fill in your details below to get started on a seamless shopping experience.",
                  textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white70))),
              SizedBox(height: 25),
              Text("Name", style: TextStyle(fontSize: 22, color: Colors.white60),),
              SizedBox(height: 7),
              Container(height: 55, width: W, child: CustomTextfield(hintText: "Enter Your Name", value: 1, onValueChanged: _onName)),
              SizedBox(height: 20),
              Text("Email", style: TextStyle(fontSize: 22, color: Colors.white60)),
              SizedBox(height: 7),
              Container(height: 55, width: W, child: CustomTextfield(hintText: "Enter Your Email", value: 2, onValueChanged: _onEmail)),
              SizedBox(height: 20),
              Text("Phone", style: TextStyle(fontSize: 22, color: Colors.white60)),
              SizedBox(height: 7),
              Container(height: 55, width: W, child: CustomTextfield(hintText: "Enter Your Phone Number", value: 3, onValueChanged: _onPhone)),
              SizedBox(height: 20),
              Text("Password", style: TextStyle(fontSize: 22, color: Colors.white60),),
              SizedBox(height: 7),
              Container(height: 55, width: W, child: Password(password: "Enter Your Password", onPasswordChanged: _onPassword)),  // Pass the callback function,
              SizedBox(height: 20),
              Text("Confirm Password", style: TextStyle(fontSize: 22, color: Colors.white60),),
              SizedBox(height: 7),
              Container(height: 55, width: W, child: Password(password: "Confirm Your Password", onPasswordChanged: _onConfirmPassword)),
              SizedBox(height: 35),
              GestureDetector(
                onTap: (){
                  if (_isName && _isPassword && _isEmail && _isPhone && _isConfirmPassword && _password == _confirmPassword){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewsFeed()));
                    print("Login button working");
                    ToastUtil.showToast(context: context, message: "Account Created Successfully");
                  } else {
                    ToastUtil.showToast(context: context, message: "Invalid Input.", isWarning: true);
                  }
                },
                child: Container(
                  height: 55,
                  width: W,
                  decoration: BoxDecoration(
                    color: Color(0xffe8f54a),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Sign Up", style: TextStyle(color: Color(0xff105866), fontSize: 25, fontWeight: FontWeight.bold),)),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Already have an account?", style: TextStyle(color: Colors.white70, fontSize: 17)),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17))
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
