import 'package:mobile_app_3/client/models/favorite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteService {
  Future<List<FavoriteModel>> fetchFavorite(int userId) async {
    List<FavoriteModel> favoriteList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/favorite.php?user_id=$userId&fetchFavorite'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        favoriteList = List<FavoriteModel>.from(
            jsonData.map((item) => FavoriteModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return favoriteList;
  }

  Future<void> addFavorite(int userId, int pdId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/favorite.php?userId=$userId&pdId=$pdId&addFavorite'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> removeFavorite(int userId, int pdId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/favorite.php?userId=$userId&pdId=$pdId&removeFavorite'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }

//  xao het san pham trong mmuc yeu thich
  Future<void> removeAllItem(int userId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/favorite.php?userId=$userId&removeAllItem'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }
}
