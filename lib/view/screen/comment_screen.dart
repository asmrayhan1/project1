import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/components/comment.dart';
import 'package:project1/components/nested_comment.dart';
import 'package:project1/components/reply.dart';
import 'package:project1/controller/comment/comment_controller.dart';
import 'package:project1/controller/reply/reply_controller.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final double h;
  final String feedId;
  const CommentScreen({super.key, required this.feedId, required this.h});

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  bool comment = true;
  bool reply = false;
  String parentId = "";
  String name = "";

  void onTapValue(bool status){
    setState(() {
      comment = true;
      reply = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((t){
      ref.read(commentProvider.notifier).getCommentData(feedId: widget.feedId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double H = widget.h;
    double firstScreen = H / 1.1;
    double secondScreen = H - firstScreen;

    final home = ref.watch(commentProvider);

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Add padding to prevent overlap
      height: H,
      child: Column(
        children: [
          Expanded(
            flex: 15,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(17.5), topRight: Radius.circular(17.5)),
              ),
              height: firstScreen,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: home.comment.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle
                                    ),
                                    child: ClipOval(child: Image.network('${home.comment[index].user?.profilePic}', fit: BoxFit.fill)),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 1.4,
                                        decoration: BoxDecoration(
                                          color: Color(0xffdcdcdc),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${home.comment[index].user?.fullName}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff040810))),
                                              Text("${home.comment[index].commentTxt}", textAlign: TextAlign.justify, style: TextStyle(fontSize: 20, color: Color(0xff040810))),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Icon(Icons.more_vert, size: 35)
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("${home.comment[index].createdAtAgo}", style: TextStyle(fontSize: 13)),
                                      SizedBox(width: 30),
                                      Text("Like", style: TextStyle(fontSize: 13)),
                                      SizedBox(width: 30),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            ref.read(commentProvider.notifier).isClicked(index: index);
                                            reply = true;
                                            comment = false;
                                            name = home.comment[index].user!.fullName!;
                                            parentId = home.comment[index].id.toString();
                                          });
                                          if (ref.watch(commentProvider).isClicked[index]) {
                                            await ref.read(
                                                replyProvider.notifier)
                                                .getReplyData(
                                                parrentId: home.comment[index]
                                                    .id.toString());
                                          }
                                        },
                                        child: Text("Reply", style: TextStyle(fontSize: 13))
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("${home.comment[index].likeCount}", style: TextStyle(fontSize: 13)),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 13,
                                        height: 13,
                                        child: ClipOval(child: Image.asset('assets/images/like1.png', fit: BoxFit.fill)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              if (home.isClicked[index])
                                Column(
                                  children: [
                                    NestedComment(parrentId: home.comment[index].id.toString()),
                                  ],
                                ),
                              SizedBox(height: 15),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: (comment)? Comment(secondScreen: secondScreen, onTapValue: onTapValue, feedId: widget.feedId)
                : Reply(name: name, parentId: parentId, feedId: widget.feedId, secondScreen: secondScreen, onReplyValue: onTapValue),
          ),
        ],
      ),
    );
  }
}
