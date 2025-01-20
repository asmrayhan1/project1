import 'package:project1/model/reply_model.dart';

class ReplyGeneric {
  bool isLoading;
  List<ReplyModel> reply;
  ReplyGeneric({this.isLoading = false, this.reply = const []});

  ReplyGeneric update({bool? isLoading, List<ReplyModel>? newReply}){
    return ReplyGeneric(
        isLoading: isLoading?? this.isLoading,
        reply: newReply?? this.reply
    );
  }
}