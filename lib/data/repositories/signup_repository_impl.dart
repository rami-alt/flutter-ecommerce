import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/entities/failure.dart';
import 'package:flutter_application_1/domain/entities/signup_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/signup_repository.dart';
import '../models/signup_user_model.dart';

class SignupRepositoryImpl implements SignupRepository {
  var apiUrl = 'https://api.escuelajs.co/api/v1/users/';
  final storage = const FlutterSecureStorage();

  @override
  Future<Either<Failure, SignupUser>> signup(SignupUser user) async {
    final userModel = SignupUserModel.fromEntity(user);
    print(jsonEncode(userModel.toJson()));
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userModel.toJson()),
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        if (data.containsKey('name') &&
            data.containsKey('email') &&
            data.containsKey('password')) {
          final signupUser = SignupUser(
            name: data['name'],
            email: data['email'],
            password: data['password'],
          );
          final userModel = SignupUserModel.fromEntity(signupUser);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(userModel.toJson()));
          await storage.write(key: 'email', value: signupUser.email);
          await storage.write(key: 'password', value: signupUser.password);

          return Right(signupUser);
        } else {
          return Left(Failure(message: 'Invalid response format'));
        }
      } else {
        return Left(Failure(message: 'invalid credentials!'));
      }
    } catch (e) {
      print(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }
}
