import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_app_3/public/intro_screen.dart';

class LoginService with ChangeNotifier {
  bool _isLoggedIn = false;
  String userRole = '';
  String userPassword = '';
  late int userId;
  bool get isLoggedIn => _isLoggedIn;

  late void Function() onLogout;

  Future<bool> login(String name, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1/api/login.php'),
      body: jsonEncode({
        'user_username': name,
        'user_password': password,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> user = jsonDecode(response.body);
        // print(response.body);
        if (user['user_role'] == "client") {
          _isLoggedIn = true;
          userId = user['user_id'];
          userPassword = user['user_password'];
          userRole = "client";
          notifyListeners();
        } else if (user['user_role'] == "admin") {
          // Xử lý khi user là admin
          _isLoggedIn = true;
          userId = user['user_id'];
          userPassword = user['user_password'];
          userRole = "admin";
          notifyListeners();
        } else if (user['user_role'] == "staff") {
          // Xử lý khi user là admin
          _isLoggedIn = true;
          userId = user['user_id'];
          userPassword = user['user_password'];
          userRole = "staff";
          notifyListeners();
        }
        return true;
      } catch (e) {
        print('Error parsing JSON: $e');
        return false;
      }
    } else {
      print('HTTP error: ${response.statusCode}');
      return false;
    }
  }

  Future<void> logout() async {
    // Reset các giá trị và đăng xuất
    _isLoggedIn = false;
    userId = 0;
    userRole = '';
    notifyListeners();
    if (onLogout != null) {
      onLogout!();
    }
  }

  Future<bool> editPassword(
      int userId, String password, String passwordNew) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/login.php'),
        body: jsonEncode({
          'userId': userId,
          'password': password,
          'passwordNew': passwordNew,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
