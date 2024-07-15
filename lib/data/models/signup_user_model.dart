// data/models/signup_user_model.dart

import 'package:flutter_application_1/domain/entities/signup_user.dart';

class SignupUserModel extends SignupUser {
  SignupUserModel({
    required String name,
    required String email,
    required String password,
  }) : super(name: name, email: email, password: password);

  factory SignupUserModel.fromJson(Map<String, dynamic> json) {
    return SignupUserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }

  static SignupUserModel fromEntity(SignupUser user) {
    return SignupUserModel(
      name: user.name,
      email: user.email,
      password: user.password,
    );
  }

  SignupUser toEntity() {
    return SignupUser(
      name: name,
      email: email,
      password: password,
    );
  }
}
