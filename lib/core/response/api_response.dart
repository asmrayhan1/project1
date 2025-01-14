import 'package:project1/model/community_model.dart';

// Main API Response Model
class ApiResponse {
  String? type;
  String? token;
  String? msg;

  ApiResponse({this.type, this.token, this.msg});

  // Factory constructor to create an instance from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      type: json['type'],
      token: json['token'],
      msg: json['msg'],
    );
  }

  // toJson method to convert ApiResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'token': token,
      'msg': msg,  // This will need to be adjusted if 'data' is a complex type
    };
  }

}