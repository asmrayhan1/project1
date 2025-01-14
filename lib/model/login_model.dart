class LoginModel {
  final String email;
  final String password;

  // Constructor to initialize the properties
  LoginModel({
    required this.email,
    required this.password,
  });

  // Factory constructor to create an instance from JSON (for API responses)
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
    );
  }

  // Method to convert the model to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
