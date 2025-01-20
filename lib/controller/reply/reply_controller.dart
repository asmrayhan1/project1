import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:project1/controller/comment/comment_generic.dart';
import 'package:project1/controller/reply/reply_generic.dart';
import 'package:project1/model/comment_model.dart';
import 'package:project1/model/reply_model.dart';

import '../../core/network/api.dart';
import '../../main.dart';

final replyProvider = StateNotifierProvider<ReplyController, ReplyGeneric> ((ref) => ReplyController());

class ReplyController extends StateNotifier<ReplyGeneric>{
  ReplyController() : super(ReplyGeneric());

  Future<void> getReplyData({required String parrentId}) async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Response response = await get(
      Uri.parse(Api.BASE_URL+Api.GET_FETCH_REPLY+parrentId+"?more=null"),
      headers: headers,
    );

    // print("Response => ${response.body}");
    print("StatusCode = ${response.statusCode}");
    state=state.update(isLoading: false);

    if (response.statusCode>=200 && response.statusCode<300) {
      List<ReplyModel> myList = [];
      try {
        //final db = await DatabaseHelper.getDatabase();
        // Clear all data from the store
        //await _store.delete(db); // Local database
        List<dynamic> data = json.decode(response.body);
        // Loop through the JSON and map each item to a CommunityModel
        for (var e in data) {
          ReplyModel reply = ReplyModel.fromJson(e as Map<String, dynamic>);
          myList.add(reply);

          //await _store.add(db, category.toJson());  // Add a new record
        }
        state = state.update(newReply: myList);
        //await getOfflineData();
      } catch (e){
        print("Error Found in Category");
      }
    } else {
      print("<<< Error Found on NewsFeed >>>");
      print("<<< Error Found on NewsFeed >>>");
    }
  }


  Future<bool> createReply({required String txt, required String feedId, required String parrentId}) async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Map<String, dynamic> body = {
      "comment_txt": txt,
      "feed_id": feedId,
      "parrent_id" : parrentId
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
      //getReplyData(feedId: feedId);
      return true;
    } else {
      return false;
    }
  }
}