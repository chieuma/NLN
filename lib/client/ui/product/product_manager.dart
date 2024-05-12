import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/color.dart';
import 'package:mobile_app_3/client/models/product_detail.dart';
import 'package:mobile_app_3/client/ui/product/product_detail_manager.dart';

import '../../services/product_service.dart';
import '../../models/product.dart';

class ProductManager with ChangeNotifier {
  List<ProductModel> _product = [];
  List<ProductModel> get product => _product;

  List<ProductModel> _productSearch = [];
  List<ProductModel> get productSearch => _productSearch;

  List<ProductModel> _productBrand = [];
  List<ProductModel> get productBrand => _productBrand;

  List<ProductModel> _productCategory = [];
  List<ProductModel> get productCategory => _productCategory;

  Future<List<ProductModel>> fetchPhone() async {
    var _fetchProduct = ProductSerivce();
    try {
      _product = await _fetchProduct.fetchPhone();
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _product;
  }

  Future<List<ProductModel>> fetchProductCategory(int categoryId) async {
    fetchPhone();
    _productCategory.clear();
    for (int i = 0; i < _product.length; i++) {
      if (_product[i].categoryId == categoryId) {
        _productCategory.add(_product[i]);
      }
    }
    return _productCategory;
  }

  Future<List<ProductModel>> fetchPhoneSearch(String name) async {
    _productSearch.clear();
    try {
      for (var searchName in _product) {
        if (searchName.productName.toLowerCase().contains(name.toLowerCase()) ||
            searchName.brand.toLowerCase().contains(name.toLowerCase())) {
          _productSearch.add(searchName);
        }
      }
    } catch (error) {
      print(error);
    }
    // notifyListeners();
    return _productSearch;
  }

  void filterBrand(String name) async {
    await fetchPhone();
    _productBrand = [];
    _productBrand = _product.where((element) => element.brand == name).toList();
    print(_productBrand.length);
  }

  Future<bool> addProduct(ProductModel product, ColorsModel color,
      ProductDetailModel productDetail, List<String> imageData) async {
    await fetchPhone();
    var _productService = ProductSerivce();
    try {
      int index = _product
          .indexWhere((element) => element.productName == product.productName);
      // Kiểm tra xem sản  phẩm đã có chưa kiểm tra theo name
      if (index >= 0) {
        int pdId = _product[index].productId!;
        print(pdId);
        await _productService.addProductName(
            pdId, color, productDetail, imageData);
      } else {
        //  print('haha');
        await _productService.addProduct(
            product, color, productDetail, imageData);
      }
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateProductName(int productId, String name) async {
    var _productService = ProductSerivce();
    var productDetail = ProductDetailManager();
    try {
      if (await _productService.updateProductName(productId, name)) {
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<bool> editProduct(
      ProductDetailModel product, List<String> image) async {
    var _productService = ProductSerivce();
    try {
      if (await _productService.editProduct(product, image)) {
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<bool> removeProduct(
      ProductDetailModel color, int countColor, int pdId) async {
    var _productService = ProductSerivce();
    if (await _productService.removeProduct(color, countColor, pdId)) {
      if (countColor > 1) {
        int index = _product.indexWhere((element) => element.productId == pdId);
        if (index >= 0) {
          _product.removeAt(index);
          notifyListeners();
        }
      }
      return true;
    }
    return false;
  }
}
