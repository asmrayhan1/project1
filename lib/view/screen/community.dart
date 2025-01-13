import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/components/custom_modal_bottom_sheet.dart';
import 'package:project1/components/reaction.dart';
import 'package:project1/controller/community/community_controller.dart';
import 'package:project1/view/screen/create_post.dart';

class Community extends ConsumerStatefulWidget {
  const Community({super.key});

  @override
  ConsumerState<Community> createState() => _CommunityState();
}

class _CommunityState extends ConsumerState<Community> {
  List<String?> imagePath = List.generate(30, (index) => "");

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(communityController).community;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          itemCount: home.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0)
                  SizedBox(height: 20),
                if (index == 0) GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePost()));
                    print("Post Button Working");
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
                            Text("${home[index].user!.fullName}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff040810)),),
                            Text("${home[index].createdAtAgo}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff667075)),),
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.more_vert, size: 35)
                  ],
                ),
                Divider(color: Color(0xffd0d5dd)),
                SizedBox(height: 5),
                Text("${home[index].feedTxt}",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16), textAlign: TextAlign.justify,
                ),
                SizedBox(height: 15),
                Container(
                  height: 162,
                  width: double.infinity,
                  child: Image.network('${home[index].pic}', fit: BoxFit.fill,),
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
                          height: 28,
                          width: 28,
                          child: GestureDetector(
                            onTap: () async {
                              final currentPath = await Reaction.showDialogBox(context);
                              setState(() {
                                imagePath[index] = currentPath;
                              });
                              print("Like button working");
                            },
                            child: Image.asset((imagePath[index] != "" && imagePath[index] != null)? '${imagePath[index]}' : 'assets/images/like.png', fit: BoxFit.fill,)
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("You and 2 others", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff181835)),)
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        CustomModalBottomSheet().newBottomSheet(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.mode_comment, size: 25),
                          SizedBox(width: 10),
                          Text("Comment", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff181835)),)
                        ],
                      ),
                    ),
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
