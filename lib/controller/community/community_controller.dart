import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/controller/community/community_generic.dart';
import 'package:http/http.dart';
import 'package:project1/core/response/api_error_response.dart';
import 'package:project1/main.dart';
import 'package:project1/model/community_model.dart';

import '../../core/network/api.dart';

final communityProvider = StateNotifierProvider<CommunityController, CommunityGeneric> ((ref) => CommunityController());

class CommunityController extends StateNotifier<CommunityGeneric> {
  CommunityController() : super(CommunityGeneric());

  Future<void> getCommunityData({required int operation}) async {
    state = state.update(isLoading: true);

    Map<String, dynamic> body;

    if (operation == 3){
      state.delete();
    }

    if (operation >= 2){
      int size = state.community.length;
      body = {
        'community_id': 2914,
        'space_id': 5883,
        'more': state.community[size - 1].id
      };
    } else {
      body = {
        'community_id': 2914,
        'space_id': 5883,
      };
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Response response = await post(
        Uri.parse(Api.BASE_URL+Api.POST_FETCH_COMMUNITY),
        headers: headers,
        body: jsonEncode(body)
    );

   // print("Response => ${response.body}");
    print("StatusCode = ${response.statusCode}");
    state=state.update(isLoading: false);

    ApiErrorResponse? errorResponse;

    if (response.statusCode < 200 || response.statusCode >= 300){
      errorResponse = ApiErrorResponse.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode>=200 && response.statusCode<300) {
      List<CommunityModel> myList = [];
      if (operation >= 2){
        for (int i = 0; i < state.community.length; i++){
          myList.add(state.community[i]);
        }
      }
      try {
        //final db = await DatabaseHelper.getDatabase();
        // Clear all data from the store
        //await _store.delete(db); // Local database
        List<dynamic> data = json.decode(response.body);
        // Loop through the JSON and map each item to a CommunityModel
        for (var e in data) {
          CommunityModel community = CommunityModel.fromJson(e as Map<String, dynamic>);
          myList.add(community);

          //await _store.add(db, category.toJson());  // Add a new record
        }
        state = state.update(newCommunity: myList);
        //await getOfflineData();
      } catch (e){
        print("Error Found in Category");
      }
    } else {
      print("<<< Error Found on NewsFeed >>>");
      print(errorResponse?.msg);
      print("<<< Error Found on NewsFeed >>>");
    }
  }

  Future<bool> createPost({required String title}) async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Map<String, dynamic> body = {
      'community_id': 2914,
      'space_id': 5883,
      'feed_txt': title,
      'uploadType': 'text',
      'activity_type': 'group',
      'is_background': '0'
    };

    Response response = await post(
        Uri.parse(Api.BASE_URL+Api.POST_CREATE),
        headers: headers,
        body: jsonEncode(body)
    );

    // print("Response => ${response.body}");
    print("Post Create StatusCode = ${response.statusCode}");
    state=state.update(isLoading: false);
    if (response.statusCode>=200 && response.statusCode<300) {
      getCommunityData(operation: 1);
      return true;
    } else {
      return false;
    }
  }

}