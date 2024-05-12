import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpService with ChangeNotifier {
  Future<bool> signUp(String userName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/signup.php'),
        body: jsonEncode({
          'userName': userName,
          'email': email,
          'password': password,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<bool> signUpAdmin(
      String userName, String email, String password, String role) async {
    try {
      print(role);
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/signup.php'),
        body: jsonEncode({
          'userNamead': userName,
          'emailad': email,
          'passwordad': password,
          'rolead': role,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }
}
