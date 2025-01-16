import 'package:project1/model/comment_model.dart';

class CommentGeneric {
  bool isLoading;
  List<CommentModel> comment;
  CommentGeneric({this.isLoading = false, this.comment = const []});

  CommentGeneric update({bool? isLoading, List<CommentModel>? newComment}){
    return CommentGeneric(
        isLoading: isLoading?? this.isLoading,
        comment: newComment?? this.comment
    );
  }
}