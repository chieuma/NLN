import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/user.dart';
import 'package:mobile_app_3/client/services/signup_service.dart';
import 'package:mobile_app_3/client/services/user_service.dart';

class UserManager with ChangeNotifier {
  List<UserModel> _user = [];

  List<UserModel> get user => _user;

  List<UserModel> _userAll = [];

  List<UserModel> get userAll => _userAll;

  List<UserModel> _userSearch = [];

  List<UserModel> get userSearch => _userSearch;

  Future<List<UserModel>> fetchUser(int userId) async {
    var _userService = UserService();
    try {
      _user = await _userService.fetchUser(userId);
      print(_user[0].image!);
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _user;
  }

  Future<List<UserModel>> fetchAllUser() async {
    print(_userAll.length);
    var _userService = UserService();
    try {
      _userAll = await _userService.fetchAllUser();
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _userAll;
  }

  // bên client
  Future<bool> editProfile(UserModel? userModel) async {
    var _userService = UserService();
    int index = _user.indexWhere((item) => item.id == userModel!.id);

    if (index >= 0) {
      if (await _userService.editProfile(userModel!)) {
        _user[index] = userModel;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> signUp(String userName, String email, String password) async {
    fetchAllUser();
    int userId = 0;
    var _signUpService = SignUpService();
    try {
      int index = _userAll.indexWhere((item) => item.name == userName);
      if (index >= 0) {
        return false;
      } else {
        await _signUpService.signUp(userName, email, password);
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  // admin thêm tài khoản
  Future<bool> signUpAdmin(
      String userName, String email, String password, String role) async {
    fetchAllUser();
    int userId = 0;
    var _signUpService = SignUpService();
    try {
      int index = _userAll.indexWhere((item) => item.name == userName);
      if (index >= 0) {
        return false;
      } else {
        await _signUpService.signUpAdmin(userName, email, password, role);
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> uploadImage(String image, int userId) async {
    var _userService = UserService();
    if (await _userService.uploadImage(image, userId)) {
      _user[0].image = Uint8List.fromList(base64Decode(image));
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  int get countClientAccount {
    //  fetchAllUser();
    int count = 0;
    for (int i = 0; i < _userAll.length; i++) {
      if (_userAll[i].role == "client") {
        count++;
      }
    }
    return count;
  }

  int countAdminAccount() {
    int count = 0;
    for (int i = 0; i < _userAll.length; i++) {
      if (_userAll[i].role == "admin") {
        count++;
      }
    }
    return count;
  }

  // tìm kiếm user
  Future<List<UserModel>> fetchUserSearch(String name) async {
    fetchAllUser();
    _userSearch.clear();
    try {
      for (var searchName in _userAll) {
        if (searchName.name.toLowerCase().contains(name.toLowerCase())) {
          _userSearch.add(searchName);
        }
      }
    } catch (error) {
      print(error);
    }
    // print(_userSearch.length);
    return _userSearch;
  }

  // Bên admin
  Future<bool> updateUser(UserModel user) async {
    await fetchAllUser();
    var _userService = UserService();
    // print('chieu');
    // print(user.date);
    try {
      for (int i = 0; i < _userAll.length; i++) {
        if (_userAll[i].id! == user.id) {
          await _userService.updateUser(user);
          notifyListeners();
          return true;
        }
      }
    } catch (error) {
      return false;
    }
    return false;
  }
}
