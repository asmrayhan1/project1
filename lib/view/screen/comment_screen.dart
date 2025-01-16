import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/controller/comment/comment_controller.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final double h;
  final String feedId;
  const CommentScreen({super.key, required this.feedId, required this.h});

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  TextEditingController _textController = TextEditingController();

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
            flex: 9,
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
                                      Text("Reply", style: TextStyle(fontSize: 13)),
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
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                height: secondScreen,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: Container(
                      height: 50,
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
                              SizedBox(width: 5),
                              Container(
                                height: 40,
                                width: 40,
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
                                    maxLines: 10, // Limits the TextField to 8 lines visually
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
                            onTap: () async {
                              if (_textController.text.trim().isNotEmpty) {
                                await ref.read(commentProvider.notifier).createPost(
                                    title: _textController.text.trim(),
                                    feedId: widget.feedId
                                );
                              }
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              width: 55,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
