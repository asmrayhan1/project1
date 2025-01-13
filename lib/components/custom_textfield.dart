import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/toast/toast_util.dart';

class CustomTextfield extends StatefulWidget {
  final String hintText;
  final int value;
  final Function(String, bool) onValueChanged;  // Callback function
  const CustomTextfield({super.key, required this.hintText, required this.value, required this.onValueChanged});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  final String emailRegex = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  final String phoneRegex = r"^01[7|6|3|8|9|5]\d{8}$";

  @override
  void initState() {
    super.initState();
    // Add listener to focusNode to detect when the TextField loses focus
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        String title = "";
        (widget.value == 1)? title = "Name" : (widget.value == 2)? title = "Email" : title = "Phone";
        if (_textController.text.trim().isEmpty){
          widget.onValueChanged(_textController.text.trim(), false);  // Trigger the callback on text change
          ToastUtil.showToast(context: context, message: "${title} Can't be Empty!", isWarning: true);
        } else if (widget.value == 2){
          if (!RegExp(emailRegex).hasMatch(_textController.text.trim())) {
            widget.onValueChanged(_textController.text.trim(), false);  // Trigger the callback on text change
            ToastUtil.showToast(context: context, message: "Invalid Email!", isWarning: true);
          } else {
            widget.onValueChanged(_textController.text.trim(), true);  // Trigger the callback on text change
          }
        } else if (widget.value == 3){
          if (!RegExp(phoneRegex).hasMatch(_textController.text.trim())) {
            widget.onValueChanged(_textController.text.trim(), false);  // Trigger the callback on text change
            ToastUtil.showToast(context: context, message: "Invalid Phone Number!", isWarning: true);
          } else {
            widget.onValueChanged(_textController.text.trim(), true);  // Trigger the callback on text change
          }
        } else {
          widget.onValueChanged(_textController.text.trim(), true);  // Trigger the callback on text change
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
      controller: _textController,
      focusNode: _focusNode,  // Attach the FocusNode to the TextField
      style: TextStyle(
        color: Colors.white,  // Set text color
        fontSize: 20,         // Optional: set font size
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        filled: true, // Enables the background color
        fillColor: Colors.white12, // Background color
        hintText: widget.hintText,
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
