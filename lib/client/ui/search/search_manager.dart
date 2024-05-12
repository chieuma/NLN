import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/search.dart';
import 'package:mobile_app_3/client/services/search_service.dart';

class SearchManager with ChangeNotifier {
  List<SearchModel> _itemSearch = [];
  List<SearchModel> get itemSearch => _itemSearch;

  Future<void> fetchSearch(int userId) async {
    var _searchService = SearchService();
    try {
      _itemSearch = await _searchService.fetchSearch(userId);
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  int get itemCount {
    return _itemSearch.length;
  }

  void addSearch(int userId, String name) async {
    var _searchService = SearchService();
    bool nameExists = _itemSearch
        .any((searchModel) => searchModel.name == name.toLowerCase().trim());
    if (nameExists) {
      return;
    } else {
      await _searchService.addSearch(userId, name);
      fetchSearch(userId);
      notifyListeners();
    }
  }

  // void clearSearch(int userId, String name) async {
  //   var _searchService = SearchService();
  //   await _searchService.clearSearch(userId, name);
  //   fetchSearch(userId);
  //   notifyListeners();
  // }

  void clearSearch(int userId, String name) async {
    var _searchService = SearchService();
    await _searchService.clearSearch(userId, name);
    _itemSearch.removeWhere((searchModel) => searchModel.name == name);
    notifyListeners();
  }
}
