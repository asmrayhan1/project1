import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/components/custom_textfield.dart';
import 'package:project1/components/password.dart';
import 'package:project1/utils/toast/toast_util.dart';
import 'package:project1/view/screen/news_feed.dart';

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

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff105866),
      appBar: AppBar(
        backgroundColor: Color(0xff105866),
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Create an Account", style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.w800))),
              Center(child: Text("Fill in your details below to get started on a seamless shopping experience.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white70))),
              SizedBox(height: 40),
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
              SizedBox(height: 35),
              GestureDetector(
                onTap: (){
                  if (_isName && _isPassword && _isEmail && _isPhone){
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
