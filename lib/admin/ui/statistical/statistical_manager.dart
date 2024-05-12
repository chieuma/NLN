import 'package:flutter/material.dart';
import 'package:mobile_app_3/admin/model/favorite.dart';
import 'package:mobile_app_3/admin/model/statistical.dart';
import 'package:mobile_app_3/admin/services/statistical_service.dart';

class StatisticalManager with ChangeNotifier {
  List<StatisticalModel> _list = [];
  List<StatisticalModel> get list => _list;

  List<FavoriteModel> _listFavorite = [];
  List<FavoriteModel> get listFavorite => _listFavorite;

  Future<List<StatisticalModel>> fetchStatistical() async {
    var _statisticalService = StatisticalService();
    try {
      _list = await _statisticalService.fetchStatistical();
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _list;
  }

  int get itemCount {
    return _list.length;
  }

  int countStatistical(int userId) {
    int i = 0;
    int index = _list.indexWhere((element) => element.userId == userId);
    if (index >= 0) {
      i = _list[index].count;
    }
    return i;
  }

  Future<List<FavoriteModel>> fetchFavorite() async {
    var _statisticalService = StatisticalService();
    try {
      _listFavorite = await _statisticalService.fetchFavorite();
      print(_listFavorite.length);
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _listFavorite;
  }

  // int countFavorite(int pdId){
  //   int count =0;
  //   for(var pd in _listFavorite)
  //   return count;
  // }
}
