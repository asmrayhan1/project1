import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/controller/reply/reply_controller.dart';

class NestedComment extends ConsumerStatefulWidget {
  final String parrentId;
  const NestedComment({super.key, required this.parrentId});

  @override
  ConsumerState<NestedComment> createState() => _NestedCommentState();
}

class _NestedCommentState extends ConsumerState<NestedComment> {

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(replyProvider);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true, // Important to make the nested list scrollable inside the parent
      itemCount: home.reply.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            children: [
              SizedBox(height: 10),
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
                    child: ClipOval(child: Image.network('${home.reply[index].user?.profilePic}', fit: BoxFit.fill)),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.85,
                        decoration: BoxDecoration(
                          color: Color(0xffdcdcdc),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${home.reply[index].user?.fullName}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff040810))),
                              Text("${home.reply[index].commentTxt}", textAlign: TextAlign.justify, style: TextStyle(fontSize: 20, color: Color(0xff040810))),
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
                      Text("${home.reply[index].createdAtAgo}", style: TextStyle(fontSize: 13)),
                      SizedBox(width: 30),
                      Text("Like", style: TextStyle(fontSize: 13)),
                      SizedBox(width: 30),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              // reply = true;
                              // comment = false;
                              // name = home.comment[index].user!.fullName!;
                              // parentId = home.comment[index].id.toString();
                              // ref.read(commentProvider.notifier).isClicked(index: index);
                            });
                          },
                          child: Text("Reply", style: TextStyle(fontSize: 13))
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("${home.reply[index].likeCount}", style: TextStyle(fontSize: 13)),
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
            ],
          ),
        );
      },
    );
  }
}
