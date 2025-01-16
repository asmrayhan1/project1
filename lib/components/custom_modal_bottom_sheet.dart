import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/model/comment_model.dart';
import 'package:project1/view/screen/comment_screen.dart';

class CustomModalBottomSheet {
  bool newBottomSheet(BuildContext context, String feedId) {
    bool isClose = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows customization of height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(17.5),
        ),
      ),
      builder: (BuildContext context) {
        double H = MediaQuery.of(context).size.height / 1.15;
        return CommentScreen(feedId: feedId, h: H);
      },
    ).whenComplete(() {
      isClose = true;
    });
    return true;
  }
}
