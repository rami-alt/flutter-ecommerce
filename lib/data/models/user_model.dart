import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required email, required accessToken, required refreshToken})
      : super(
            email: email,
            accessToken: accessToken,
            refreshToken:
                refreshToken); //super( email: email,password: password);

  @override
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
