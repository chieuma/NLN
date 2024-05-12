import 'package:mobile_app_3/admin/model/favorite.dart';
import 'package:mobile_app_3/admin/model/statistical.dart';

import '../../client/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatisticalService {
  Future<List<StatisticalModel>> fetchStatistical() async {
    List<StatisticalModel> _list = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/admin/statistical.php?fetchStatistical'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        _list = List<StatisticalModel>.from(
            jsonData.map((item) => StatisticalModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return _list;
  }

  Future<List<FavoriteModel>> fetchFavorite() async {
    List<FavoriteModel> _list = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/admin/statistical.php?fetchFavorite'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(response.body);
        _list = List<FavoriteModel>.from(
            jsonData.map((item) => FavoriteModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return _list;
  }
}
