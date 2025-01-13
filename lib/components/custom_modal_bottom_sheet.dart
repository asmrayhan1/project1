import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomModalBottomSheet {
  void newBottomSheet(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows customization of height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(17.5),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Add padding to prevent overlap
            height: MediaQuery.of(context).size.height / 1.15, // Set a specific height for the bottom sheet
            child: Column(
              children: [
                Flexible(
                  flex: 13,
                  child: Column(
                    children: [
                      Center(child: Text("data", style: TextStyle(fontSize: 30))),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xffdcdcdc),
                          borderRadius: BorderRadius.circular(60)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 15),
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle
                                ),
                                child: ClipOval(child: Image.asset('assets/images/person_icon.png', fit: BoxFit.fill)),
                              ),
                              SizedBox(width: 15),
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: TextField(
                                    controller: _textController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1, // Limits the TextField to 8 lines visually
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Write a comment',
                                      hintStyle: TextStyle(color: Colors.blueGrey),
                                    )
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              height: 70,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Color(0xff004852),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
                              ),
                              child: Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset('assets/images/sent.png', fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
