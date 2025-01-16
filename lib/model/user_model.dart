class User {
  int? id;
  String? fullName;
  String? profilePic;
  String? status;
  String? userType;
  Map<String, dynamic>? meta;

  User({
    this.id,
    this.fullName,
    this.profilePic,
    this.status,
    this.userType,
    this.meta
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      status: json['status'],
      userType: json['user_type'],
      meta: json['meta'] ?? {},
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_pic': profilePic,
      'user_type': userType,
      'meta': meta,
    };
  }
}
