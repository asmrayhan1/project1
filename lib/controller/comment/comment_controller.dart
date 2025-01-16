import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:project1/controller/comment/comment_generic.dart';
import 'package:project1/model/comment_model.dart';

import '../../core/network/api.dart';
import '../../main.dart';

final commentProvider = StateNotifierProvider<CommentController, CommentGeneric> ((ref) => CommentController());

class CommentController extends StateNotifier<CommentGeneric>{
  CommentController() : super(CommentGeneric());

  Future<void> getCommentData({required String feedId}) async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Response response = await get(
        Uri.parse(Api.BASE_URL+Api.GET_FETCH_COMMENT+feedId+"??more=null"),
        headers: headers,
    );

    // print("Response => ${response.body}");
    print("StatusCode = ${response.statusCode}");
    state=state.update(isLoading: false);

    if (response.statusCode>=200 && response.statusCode<300) {
      List<CommentModel> myList = [];
      try {
        //final db = await DatabaseHelper.getDatabase();
        // Clear all data from the store
        //await _store.delete(db); // Local database
        List<dynamic> data = json.decode(response.body);
        // Loop through the JSON and map each item to a CommunityModel
        for (var e in data) {
          CommentModel comment = CommentModel.fromJson(e as Map<String, dynamic>);
          myList.add(comment);

          //await _store.add(db, category.toJson());  // Add a new record
        }
        state = state.update(newComment: myList);
        //await getOfflineData();
      } catch (e){
        print("Error Found in Category");
      }
    } else {
      print("<<< Error Found on NewsFeed >>>");
      print("<<< Error Found on NewsFeed >>>");
    }
  }


  Future<bool> createPost({required String title, required String feedId}) async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Map<String, dynamic> body = {
      "comment_txt": title,
      "feed_id": feedId
    };

    Response response = await post(
        Uri.parse(Api.BASE_URL+Api.POST_CREATE_COMMENT),
        headers: headers,
        body: jsonEncode(body)
    );

    // print("Response => ${response.body}");
    print("Post Create StatusCode = ${response.statusCode}");
    state=state.update(isLoading: false);
    if (response.statusCode>=200 && response.statusCode<300) {
      getCommentData(feedId: feedId);
      return true;
    } else {
      return false;
    }
  }

  void clear(){
    List<CommentModel> clr = [];
    state = state.update(newComment: clr);
  }
}