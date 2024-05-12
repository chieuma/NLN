import 'package:mobile_app_3/client/models/cart.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_3/client/models/order_1item.dart';
import 'dart:convert';

import 'package:mobile_app_3/client/models/order_detail.dart';
import 'package:mobile_app_3/client/models/productsell.dart';

class OrderService {
  Future<List<OrderModel>> fetchOrder(int userId) async {
    List<OrderModel> orderList = [];

    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/order.php?userId=$userId&fetchOrder'));
      if (response.statusCode == 200) {
        // print(response.body);
        final jsonData = jsonDecode(response.body);

        orderList = List<OrderModel>.from(
            jsonData.map((item) => OrderModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return orderList;
  }

  Future<List<OrderDetailModel>> fetchOrderDetail(int userId) async {
    List<OrderDetailModel> orderList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/order.php?userId=$userId&fetchOrderDetail'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        orderList = List<OrderDetailModel>.from(
            jsonData.map((item) => OrderDetailModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return orderList;
  }

  Future<void> addOrder(OrderModel order, List<CartModel> cart) async {
    try {
      final List<Map<String, dynamic>> cartJson =
          cart.map((item) => item.toJson()).toList();
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/order.php'),
        body: jsonEncode({
          'order': order.toJson(),
          'cart': cartJson,
        }),
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> add1Order(OrderModel order, Order1ItemModel order1item) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/order.php'),
        body: jsonEncode({
          'order1Item': order.toJson(),
          'cart': order1item.toJson(),
        }),
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeOrder(
      OrderModel order, List<OrderDetailModel> orderDetail) async {
    try {
      final List<Map<String, dynamic>> orderJson =
          orderDetail.map((item) => item.toJson()).toList();
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/order.php'),
        body: jsonEncode({
          'order': order.toJson(),
          'orderDetail': orderJson,
        }),
      );
      print('haha');
    } catch (error) {
      print(error);
    }
  }

  //admin
  Future<List<OrderModel>> fetchAllOrder() async {
    List<OrderModel> orderList = [];
    try {
      final response = await http.get(
          Uri.parse('http://192.168.56.1/api/client/order.php?fetchAllOrder'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        orderList = List<OrderModel>.from(
            jsonData.map((item) => OrderModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return orderList;
  }

  Future<List<OrderDetailModel>> fetchAllDetailOrder(int orderId) async {
    List<OrderDetailModel> orderList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/order.php?fetchAllDetailOrder&orderId=$orderId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        orderList = List<OrderDetailModel>.from(
            jsonData.map((item) => OrderDetailModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return orderList;
  }

  Future<bool> checkedOrder(int orderId) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/order.php?checkedOrder&orderId=$orderId'));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<List<ProductSellModel>> fetchCountAllOrderDetail() async {
    List<ProductSellModel> orderList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/order.php?fetchCountAllOrderDetail'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        //print(response.body);
        orderList = List<ProductSellModel>.from(
          jsonData.map((item) => ProductSellModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return orderList;
  }
}
