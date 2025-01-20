import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/controller/community/community_controller.dart';
import 'package:project1/utils/toast/toast_util.dart';

class CreatePost extends ConsumerStatefulWidget {
  const CreatePost({super.key});

  @override
  ConsumerState<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> {
  TextEditingController _textController = TextEditingController();
  bool isClicked = false;
  int idx = 0;
  List<Color> clr = [
    Colors.white, // white
    Color(0xfffa2828), // Red
    Color(0xffc2fa28), // Greenish Yellow
    Color(0xfff7fa28), // Yellow
    Color(0xffffa481), // Orange
    Color(0xff28fade), // Light Blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Close", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff161a37)))
                ),
                Text("Create Post", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff000000)),),
                GestureDetector(
                    onTap: () async {
                      if (_textController.text.trim().isEmpty){
                        ToastUtil.showToast(context: context, message: "Field can't be empty!", isWarning: true);
                      } else {
                        bool isOkay = await ref.read(communityProvider.notifier).createPost(title: _textController.text.trim());
                        ToastUtil.showToast(context: context, message: isOkay? "Post Successfully Created" : "Error Found!", isWarning: isOkay? false : true);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Create", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff6662ff)))
                ),
              ],
            ),
            SizedBox(height: 30),
            TextField(
              controller: _textController,
              style: TextStyle(
                color: (idx != 1)? Colors.black : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 8, // Limits the TextField to 8 lines visually
              cursorColor: (idx == 1)? Colors.white : Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: clr[idx],
                hintText: 'What\'s on your mind?',
                hintStyle: TextStyle(color: (idx == 1)? Colors.white70 : Colors.blueGrey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      FocusScope.of(context).unfocus();
                      isClicked = !isClicked;
                    });
                  },
                  child: Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: clr[idx],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(child: Icon(isClicked? Icons.arrow_forward_ios : Icons.arrow_back_ios_new_rounded, size: 20,)),
                  ),
                ),
                if (isClicked)
                  SizedBox(
                    height: 26, // Set the height of the ListView to prevent overflow
                    width: MediaQuery.of(context).size.width - 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: clr.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){setState(() {
                            idx = index;
                          });},
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                              color: clr[index],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
