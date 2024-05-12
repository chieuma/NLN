import 'package:mobile_app_3/client/models/search.dart';

import '../../client/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchService {
  Future<List<SearchModel>> fetchSearch(int userId) async {
    List<SearchModel> searchList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/search.php?userId=$userId&search'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        searchList = List<SearchModel>.from(
            jsonData.map((item) => SearchModel.fromJson(item)));
      }
      // for (SearchModel cate in searchList) {
      //   print(cate.name);
      //  }
    } catch (error) {
      print(error);
    }
    print(searchList.length);
    return searchList;
  }

  Future<void> addSearch(int userId, String name) async {
    List<SearchModel> searchList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/search.php?userId=$userId&name=$name&addSearch'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        searchList = List<SearchModel>.from(
            jsonData.map((item) => SearchModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> clearSearch(int userId, String name) async {
    List<SearchModel> searchList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/search.php?userId=$userId&name=$name&clearSearch'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        searchList = List<SearchModel>.from(
            jsonData.map((item) => SearchModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
  }
}
