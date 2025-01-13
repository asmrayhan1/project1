import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/utils/toast/toast_util.dart';

class Password extends StatefulWidget {
  final String password;
  final Function(String, bool) onPasswordChanged;  // Callback function
  const Password({super.key, required this.password, required this.onPasswordChanged});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController _passwordController = TextEditingController();

  FocusNode _focusNode = FocusNode(); // Create a FocusNode
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // Add listener to focusNode to detect when the TextField loses focus
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (_passwordController.text.trim().isEmpty){
          widget.onPasswordChanged(_passwordController.text.trim(), false);  // Trigger the callback on text change
          ToastUtil.showToast(context: context, message: "Password Can't be Empty!", isWarning: true);
        } else if (_passwordController.text.trim().length < 8){
          widget.onPasswordChanged(_passwordController.text.trim(), false);  // Trigger the callback on text change
          ToastUtil.showToast(context: context, message: "Password must be at least 8 character!", isWarning: true);
        } else {
          widget.onPasswordChanged(_passwordController.text.trim(), true);  // Trigger the callback on text change
        }
      }
      print("Password Working");
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose of the FocusNode to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _passwordController,
      obscureText: _obscureText,
      focusNode: _focusNode,  // Attach the FocusNode to the TextField
      style: TextStyle(
        color: Colors.white,  // Set text color
        fontSize: 20,         // Optional: set font size
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;  // Toggle the visibility
            });
          },
        ),
        filled: true, // Enables the background color
        fillColor: Colors.white12, // Background color
        hintText: widget.password,
        hintStyle: TextStyle(color: Colors.blueGrey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white60, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white60, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        // Padding inside the text field
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }
}
