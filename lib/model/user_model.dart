class User {
  int? id;
  String? fullName;
  String? profilePic;
  String? status;
  String? userType;

  User({
    this.id,
    this.fullName,
    this.profilePic,
    this.status,
    this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      status: json['status'],
      userType: json['user_type'],
    );
  }
}
