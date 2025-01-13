import 'package:project1/model/community_model.dart';

// Main API Response Model
class ApiResponse {
  List<dynamic> data;

  ApiResponse({required this.data});

  // Factory constructor to create an instance from JSON
  factory ApiResponse.fromJson(List<dynamic> json) {
    return ApiResponse(
      data: json, // Directly assign the list of posts
    );
  }
}