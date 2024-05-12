import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/favorite.dart';
import 'package:mobile_app_3/client/models/product.dart';
import 'package:mobile_app_3/client/services/favorite_service.dart';

class FavoriteManager with ChangeNotifier {
  List<FavoriteModel> _favorite = [];
  List<FavoriteModel> get favorite => _favorite;

  Future<void> fetchFavorite(int userId) async {
    var _fetchFav = FavoriteService();
    try {
      _favorite = await _fetchFav.fetchFavorite(userId);
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  void addFavorite(int userId, int pdId) async {
    var _fetchFav = FavoriteService();
    _fetchFav.addFavorite(userId, pdId);
    await fetchFavorite(userId);
    notifyListeners();
  }

  void removeAllItem(int userId) async {
    var _fetchFav = FavoriteService();
    await _fetchFav.removeAllItem(userId);
    _favorite = [];
    notifyListeners();
  }

  void removeFavorite(int userId, int pdId) async {
    print('remove');
    var _fetchFav = FavoriteService();
    await _fetchFav.removeFavorite(userId, pdId);
    _favorite.removeWhere((favorite) =>
        favorite.favPdId == pdId); // Remove the favorite from the local list
    notifyListeners();
  }

  int countFavoriteItem(int userId) {
    int count = 0;
    count = _favorite.length;
    return count;
  }
}
