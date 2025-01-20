import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/components/reaction.dart';
import 'package:project1/controller/community/community_controller.dart';
import 'package:project1/view/screen/create_post.dart';

import '../../controller/comment/comment_controller.dart';
import 'comment_screen.dart';

class Community extends ConsumerStatefulWidget {
  const Community({super.key});

  @override
  ConsumerState<Community> createState() => _CommunityState();
}

class _CommunityState extends ConsumerState<Community> {
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
    return isClose;
  }
  
  String check(String? reaction){
    if (reaction == null) return "assets/images/like.png";
    if (reaction == "LIKE") return "assets/images/like.png";
    if (reaction == "WOW") return "assets/images/wow.png";
    if (reaction == "SAD") return "assets/images/sad.png";
    if (reaction == "LOVE") return "assets/images/love1.png";
    if (reaction == "ANGRY") return "assets/images/angry.png";
    if (reaction == "CARE") return "assets/images/care.png";
    if (reaction == "HAHA") return "assets/images/haha.png";
    return "assets/images/like.png";
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(communityProvider).community;
    int size = home.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          itemCount: size + 1,
          itemBuilder: (context, index) {
            if (index == size){
              return Center(child: const CircularProgressIndicator());
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0)
                      SizedBox(height: 20),
                    if (index == 0) GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CreatePost()));
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
                                  child: Image.asset(
                                    'assets/images/person_icon.png',
                                    fit: BoxFit.fill,),
                                ),
                              ),
                              Positioned(
                                  child: Center(child: Text(
                                    "Write Something here...", style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff98a2b3)),))
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
                                  child: Center(child: Text("Post",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),)),
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
                              child: ClipOval(child: Image.asset(
                                'assets/images/person_icon.png',
                                fit: BoxFit.fill,)),
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${home[index].user!.fullName}",
                                  style: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff040810)),),
                                Text("${home[index].createdAtAgo}",
                                  style: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff667075)),),
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
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 162,
                      width: double.infinity,
                      child: Image.network(
                        '${home[index].pic}', fit: BoxFit.fill,),
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
                                    final currentPath = await Reaction
                                        .showDialogBox(context);
                                    setState(() {
                                      //
                                    });
                                    print("Like button working");
                                  },
                                  child: Image.asset(
                                    check((home[index].likeType!.isEmpty)?
                                      null : home[index].likeType?[0].reactionType), fit: BoxFit.fill)
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("You and 2 others", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff181835)),)
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            bool isNotActive = newBottomSheet(context, home[index].id.toString());
                            if (isNotActive) {
                              ref.read(commentProvider.notifier).clear();
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.mode_comment, size: 25),
                              SizedBox(width: 10),
                              Text("${home[index]
                                  .commentCount} Comment${(home[index]
                                  .commentCount! > 1) ? "'s" : ""}",
                                style: TextStyle(fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff181835)),)
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
              );
            }
          },
      ),
    );
  }
}