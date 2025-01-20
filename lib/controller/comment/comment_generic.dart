import 'package:project1/model/comment_model.dart';

class CommentGeneric {
  bool isLoading;
  List<CommentModel> comment;
  List<bool> isClicked;
  CommentGeneric({this.isLoading = false, this.comment = const [], this.isClicked = const []});

  CommentGeneric update({bool? isLoading, List<CommentModel>? newComment, List<bool>? isClicked}){
    return CommentGeneric(
        isLoading: isLoading?? this.isLoading,
        comment: newComment?? this.comment,
        isClicked: isClicked?? this.isClicked
    );
  }
}