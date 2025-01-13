import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/controller/community/community_generic.dart';
import 'package:http/http.dart';
import 'package:project1/core/response/api_error_response.dart';
import 'package:project1/main.dart';
import 'package:project1/model/community_model.dart';

import '../../core/network/api.dart';

final communityController = StateNotifierProvider<CommunityController, CommunityGeneric> ((ref) => CommunityController());

class CommunityController extends StateNotifier<CommunityGeneric> {
  CommunityController() : super(CommunityGeneric());

  Future<void> getCommunityData() async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token}'
    };

    Map<String, int> body = {
      'community_id': 2914,
      'space_id': 5883,
    };

    Response response = await post(
        Uri.parse(Api.BASE_URL+Api.POST_FETCH_COMMUNITY),
        headers: headers,
        body: jsonEncode(body)
    );

    // print("Response => ${response.body}");
    print("StatusCode = ${response.statusCode}");
    state=state.update(isLoading: false);

    ApiErrorResponse errorResponse = ApiErrorResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode>=200 && response.statusCode<300) {
      List<CommunityModel> myList = [];
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
      print(errorResponse.msg);
      print("<<< Error Found on NewsFeed >>>");
    }
  }

}