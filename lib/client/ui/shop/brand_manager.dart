import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/brand.dart';
import 'package:mobile_app_3/client/services/brand_service.dart';

class BrandManager with ChangeNotifier {
  List<BrandModel> _itemAllBrand = [];
  List<BrandModel> get itemAllBrand => _itemAllBrand;

  List<BrandModel> _itemBrand = [];
  List<BrandModel> get itemBrand => _itemBrand;

  Future<List<BrandModel>> fetchBrand() async {
    var _brandService = BrandService();
    try {
      _itemAllBrand = await _brandService.fetchBrand();
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _itemAllBrand;
  }

  Future<List<BrandModel>> fetchBrandCategory(int categoryId) async {
    await fetchBrand();
    _itemBrand.clear();
    for (int i = 0; i < _itemAllBrand.length; i++) {
      if (_itemAllBrand[i].categoryId == categoryId) {
        _itemBrand.add(_itemAllBrand[i]);
      }
      notifyListeners();
    }
    // print(_itemBrand);
    return _itemBrand;
  }

  Future<bool> addBrand(int id, String name) async {
    var _brandService = BrandService();
    try {
      if (await _brandService.addBrand(id, name)) {
        return true;
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> removeBrand(int id) async {
    var _brandService = BrandService();
    try {
      if (await _brandService.removeBrand(id)) {
        int index = itemBrand.indexWhere((element) => element.id == id);
        if (index >= 0) {
          _itemBrand.removeAt(index);
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
    return _itemAllBrand.length;
  }
}
