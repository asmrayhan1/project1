import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/controller/reply/reply_controller.dart';
import 'package:project1/utils/toast/toast_util.dart';

class Reply extends ConsumerStatefulWidget {
  final String name;
  final String parentId;
  final String feedId;
  final double secondScreen;
  final Function(bool) onReplyValue;
  const Reply({super.key,
    required this.name,
    required this.feedId,
    required this.parentId,
    required this.secondScreen,
    required this.onReplyValue
  });

  @override
  ConsumerState<Reply> createState() => _ReplyState();
}

class _ReplyState extends ConsumerState<Reply> {
  TextEditingController _textController = TextEditingController();
  FocusNode replyFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t){
      // Safely request focus after context has been initialized
      FocusScope.of(context).requestFocus(replyFocusNode);
      _textController.text = widget.name + ": ";
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: widget.secondScreen,
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
                        child: SingleChildScrollView(
                          child: TextField(
                            controller: _textController,
                            focusNode: replyFocusNode,
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
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_textController.text.trim().isNotEmpty) {
                        bool okay = await ref.read(replyProvider.notifier).createReply(
                            txt: _textController.text.trim(),
                            feedId: widget.feedId,
                            parrentId: widget.parentId
                        );
                        if (!okay) ToastUtil.showToast(context: context, message: "Error Found!", isWarning: true);
                        else print("Reply Successfully Created");
                      }
                      FocusScope.of(context).unfocus();
                      print(_textController.text.trim());
                      widget.onReplyValue(false);
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
                          child: Icon(Icons.send, color: Colors.yellow, size: 23),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
