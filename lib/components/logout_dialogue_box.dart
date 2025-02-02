import 'package:flutter/material.dart';
import 'package:project1/view/screen/user_auth/login_screen.dart';
import 'package:project1/view/screen/user_auth/registration_screen.dart';

import '../main.dart';

class LogoutDialogBox {
  // Static method to show the dialog
  static void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
          content: Text('Are you shure, you want to logout?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
          actions: <Widget>[
            Divider(color: Colors.grey),
            // A Row for the buttons with dividers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Left button (Logout)
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop(); // Close dialog
                      // Add Logout logic here
                      print('Logged out');
                      await prefs.remove('token');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text('Yes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xff686868))),
                  ),
                ),
                // Vertical Divider
                Container(
                  height: 60,
                  child: VerticalDivider(color: Colors.grey),
                ),
                // Right button (Cancel)
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: Text('No', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xff686868))),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
