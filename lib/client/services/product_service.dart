import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_3/admin/ui/product/update_productName_screen.dart';
import 'package:mobile_app_3/client/models/color.dart';

import 'package:mobile_app_3/client/models/product_detail.dart';
import 'dart:convert';
import '../models/product.dart';
import '../models/category.dart';

class ProductSerivce {
  Future<List<ProductModel>> fetchPhone() async {
    List<ProductModel> productList = [];
    try {
      final response = await http.get(
          Uri.parse('http://192.168.56.1/api/client/product.php?name=phone'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        productList = List<ProductModel>.from(
            jsonData.map((item) => ProductModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return productList;
  }

  Future<List<ProductDetailModel>> fetchPhoneDetail(int id) async {
    final response = await http.get(
        Uri.parse('http://192.168.56.1/api/client/product.php?product_id=$id'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // print(response.body);
      final List<ProductDetailModel> productList =
          List<ProductDetailModel>.from(
              jsonData.map((item) => ProductDetailModel.fromJson(item)));
      return productList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> addProduct(ProductModel product, ColorsModel color,
      ProductDetailModel productDetail, List<String> imageData) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/product.php'),
        body: jsonEncode(
          {
            'product': product.toJson(),
            'color': color.toJson(),
            'productDetail': productDetail.toJson(),
            'imageData': imageData,
          },
        ),
      );
      if (response.statusCode == 200) {
        // print(response.body);
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }

  // Add thêm màu và thông tin chi tiết của sản phẩm khi đã tồn tại sản phẩm
  Future<bool> addProductName(int pdId, ColorsModel color,
      ProductDetailModel productDetail, List<String> imageData) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/product.php'),
        body: jsonEncode(
          {
            'pdId': pdId,
            'color': color.toJson(),
            'productDetail': productDetail.toJson(),
            'imageData': imageData,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }

  Future<bool> updateProductName(int productId, String name) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/product.php'),
        body: jsonEncode(
          {
            'pdId': productId,
            'name': name,
          },
        ),
      );
      if (response.statusCode == 200) {
        //    print('hahah');
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<bool> editProduct(
      ProductDetailModel product, List<String> image) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/product.php'),
        body: jsonEncode(
          {
            'product': product.toJsonEdit(),
            'image': image,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<bool> removeProduct(
      ProductDetailModel color, int countColor, int pdId) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.56.1/api/client/product.php?removeProduct&pdId=$color'),
        body: jsonEncode(
          {
            "removeColor": color.toJsonEdit(),
            "countColor": countColor,
            "pdId": pdId,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }
}
