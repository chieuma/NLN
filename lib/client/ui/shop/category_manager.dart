import 'dart:async';

import 'package:flutter/material.dart';
import '../../services/category_service.dart';
import '../../models/category.dart';

class CategoryManager with ChangeNotifier {
  List<CategoryModel> _itemCategory = [];
  List<CategoryModel> get itemCategory => _itemCategory;

  Future<List<CategoryModel>> fetchCategory() async {
    var _categoryService = CategoryService();
    try {
      _itemCategory = await _categoryService.fetchCategory();
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _itemCategory;
  }

  Future<bool> addCategory(String name) async {
    var _categoryService = CategoryService();
    try {
      if (await _categoryService.addCategory(name)) {
        return true;
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> removeCategory(int id) async {
    var _categoryService = CategoryService();
    try {
      if (await _categoryService.removeCategory(id)) {
        int index = itemCategory.indexWhere((element) => element.id == id);
        if (index >= 0) {
          _itemCategory.removeAt(index);
          notifyListeners();
        }
        return true;
      }
      return false;
    } catch (error) {
      print(error);
    }
    return false;
  }

  int get itemCount {
    return _itemCategory.length;
  }
}
