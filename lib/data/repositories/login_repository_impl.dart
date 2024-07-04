import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements LoginRepository {
  final String apiUrl = 'https://api.escuelajs.co/api/v1/auth/login';
  final storage = const FlutterSecureStorage();

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        if (data.containsKey('access_token') &&
            data.containsKey('refresh_token')) {
          final user = User(
            accessToken: data['access_token'],
            refreshToken: data['refresh_token'],
            email: email,
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(user));
          await storage.write(key: 'email', value: email);
          await storage.write(key: 'password', value: password);

          return Right(user);
        } else {
          return Left(Failure(message: 'Invalid response format'));
        }
      } else {
        return Left(Failure(
            message:
                'Failed to login with status code: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
