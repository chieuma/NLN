import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_app_3/client/models/cart.dart';

class CartService {
  Future<List<CartModel>> fetchCart(int userId) async {
    List<CartModel> cartList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/cart.php?user_id=$userId&fetchCart'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        cartList = List<CartModel>.from(
            jsonData.map((item) => CartModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return cartList;
  }

// update số lượng tại giỏ hàng
  Future<void> updateQuantity(int cartId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/cart.php?cartId=$cartId&updateQuantity'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> removeQuantity(int cartId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/cart.php?cartId=$cartId&removeQuantity'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }

// update số lượng tại trang chi tiết sản phẩm
  Future<void> updateQuantityOpt(int cartId, int quantity) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/cart.php?cartId=$cartId&quantity=$quantity&opt'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> removeOneItem(int cartId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/cart.php?cartId=$cartId&remove'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> removAllItem(int userId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/cart.php?user_id=$userId&removeAllItem'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addItemToCart(
    int userId,
    int opt,
    int quantity,
  ) async {
    //print('haha');
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/cart.php?userId=$userId&opt=$opt&quantity=$quantity&addItemToCart'));
    if (response.statusCode == 200) {
      // await fetchCart(userId);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> check(int cartId, String check) async {
    final response = await http.get(Uri.parse(
        'http://192.168.56.1/api/client/cart.php?cartId=$cartId&check=$check&changeCheck'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load data');
    }
  }
}
