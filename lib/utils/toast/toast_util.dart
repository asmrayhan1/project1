import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToastUtil {

  static showToast({required BuildContext context, required String message, bool isWarning = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
        backgroundColor: isWarning ? Colors.red : Colors.green,
      ),
    );
  }
}