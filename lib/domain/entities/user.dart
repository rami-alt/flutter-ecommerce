class User {
  final String email;
  final String accessToken;
  final String refreshToken;
  User(
      {required this.email,
      required this.accessToken,
      required this.refreshToken});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
