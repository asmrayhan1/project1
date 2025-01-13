// Error Response Model
class ApiErrorResponse {
  final String code;
  final String msg;

  ApiErrorResponse({required this.code, required this.msg});

  // Factory constructor to create an instance from JSON
  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      code: json['code'],
      msg: json['msg'],
    );
  }

  // Convert object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
    };
  }
}
