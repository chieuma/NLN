import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_3/client/models/brand.dart';

import 'package:mobile_app_3/client/models/user.dart';

class UserService {
  Future<List<UserModel>> fetchUser(int userId) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/user.php?fetchUser&userId=$userId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData != null && jsonData is List) {
          return List<UserModel>.from(
              jsonData.map((userJson) => UserModel.fromJson(userJson)));
        } else {
          throw Exception('Invalid or empty JSON data');
        }
      } else if (response.statusCode == 204) {
        return []; // Return empty list
      } else {
        throw Exception('Failed to fetch user: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user: $error');
      throw Exception('Failed to fetch user');
    }
  }

  Future<List<UserModel>> fetchAllUser() async {
    List<UserModel> userAllList = [];
    try {
      final response = await http
          .get(Uri.parse('http://192.168.56.1/api/user.php?fetchAllUser'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        userAllList = List<UserModel>.from(
            jsonData.map((item) => UserModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return userAllList;
  }

  Future<bool> editProfile(UserModel? user) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/user.php'),
        body: jsonEncode(
          {
            'user': user?.toJson(),
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }

  Future<bool> editImage(int userId, String imagePath) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/user.php'),
        body: jsonEncode(
          {
            'userId': userId,
            'imagePath': imagePath,
          },
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );
      // print('hahah');
      // print(response.body);
    } catch (error) {
      print(error);
      return false;
    }
    return true;
  }

  Future<bool> uploadImage(String imageData, int userId) async {
    try {
      var data = {
        "image": imageData,
        "userId": userId.toString(),
      };
      var respone = await http
          .post(Uri.parse('http://192.168.56.1/api/user.php'), body: data);
      if (respone.statusCode == 200) {
        // print(respone.body);
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  // Future<void> addUser(List<String> imageData) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://192.168.56.1/api/user.php'),
  //       body: {
  //         'imageData': jsonEncode(imageData), // Encode the list of strings
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       // print(response.body);
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future<bool> updateUser(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/user.php'),
        body: jsonEncode(
          {
            'updateUser': user.toJson(),
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    // đã sửa
    return false;
  }
}
