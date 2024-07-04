import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required email,
      required accessToken,
      required refreshToken}) : super (email:email,accessToken: accessToken ,refreshToken: refreshToken); //super( email: email,password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
     
      'email': email,
      'accessToken': accessToken, 
      'refreshToken': refreshToken,
      };
  }
}
