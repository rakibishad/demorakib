import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';



class UserRepository {
  Future<String> loginUser(String email, String password) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token']; // only token is returned on login
    } else {
      final error = json.decode(response.body);
      throw Exception(error['error'] ?? 'Login failed are doing something wrong');
    }
  }
}
