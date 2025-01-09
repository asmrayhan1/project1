import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (index == 0)
                  SizedBox(height: 20),
                if (index == 0) GestureDetector(
                  onTap: (){
                    print("Post Button Woriking");
                  },
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Container(
                              height: 90,
                              width: 70,
                              child: Image.asset('assets/images/person_icon.png', fit: BoxFit.fill,),
                            ),
                          ),
                          Positioned(
                              child: Center(child: Text("Write Something here...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xff98a2b3)),))
                          ),
                          Positioned(
                            top: 19,
                            right: 0,
                            child: Container(
                              height: 42,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: Color(0xff004852),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(child: Text("Post", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 37,
                          width: 37,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: ClipOval(child: Image.asset('assets/images/person_icon.png', fit: BoxFit.fill,)),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Alexander John", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff040810)),),
                            Text("2 days ago", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff667075)),),
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.more_vert, size: 35)
                  ],
                ),
                Divider(color: Color(0xffd0d5dd)),
                SizedBox(height: 5),
                Text("Hello everyone   this is a post from app to see if attached link is "
                    "working or not. Here is a link https://www.merriam-webster.com/dictionary/link  "
                    "but I think this is not working. This should work but not working!!!!",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14), textAlign: TextAlign.justify,
                ),
                SizedBox(height: 15),
                Container(
                  height: 162,
                  width: double.infinity,
                  child: Image.asset('assets/images/post1.png', fit: BoxFit.fill,),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 18,
                          width: 34,
                          child: Image.asset('assets/images/like_icon.png', fit: BoxFit.fill,),
                        ),
                        SizedBox(width: 10),
                        Text("You and 2 others", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff333741)),)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.mode_comment_outlined, size: 20),
                        SizedBox(width: 10),
                        Text("2 comments", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff333741)),)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/images/like.png', fit: BoxFit.fill,),
                        ),
                        SizedBox(width: 10),
                        Text("You and 2 others", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff181835)),)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.mode_comment, size: 25),
                        SizedBox(width: 10),
                        Text("Comment", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff181835)),)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
              ],
            );
          }
      ),
    );
  }
}
