import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:mobile_app_3/client/models/productsell.dart';
import 'package:mobile_app_3/client/services/order_service.dart';

class OrderManager with ChangeNotifier {
  // client
  List<OrderModel> _orderList = [];
  List<OrderModel> get orderList => _orderList;

  // admin
  List<OrderModel> _orderListAdmin = [];
  List<OrderModel> get orderListAdmin => _orderListAdmin;

  List<ProductSellModel> _countOrderList = [];
  List<ProductSellModel> get countOrderList => _countOrderList;

  List<Map<OrderModel, int>> _countSellItem = [];

  //fetch thong tin order co id va thong tin nguoi dat hang
  Future<void> fetchOrder(int userId) async {
    var _fetchOrder = OrderService();
    try {
      _orderList = await _fetchOrder.fetchOrder(userId);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      int index =
          _orderList.indexWhere((element) => element.orderId == order.orderId!);
      _orderList.removeAt(index);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  // admin
  Future<void> fetchAllOrder() async {
    var _fetchAllOrder = OrderService();
    try {
      _orderListAdmin = await _fetchAllOrder.fetchAllOrder();
      print(_orderListAdmin.length);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<bool> checkedOrder(int orderId) async {
    var _order = OrderService();
    try {
      int index =
          _orderListAdmin.indexWhere((element) => element.orderId == orderId);
      if (index >= 0) {
        if (await _order.checkedOrder(orderId)) {
          _orderListAdmin[index].status = "Đã xác nhận";
          notifyListeners();
          return true;
        }
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  int countChecked(int userId) {
    int count = 0;
    for (int i = 0; i < _orderListAdmin.length; i++) {
      if (_orderListAdmin[i].userId == userId &&
          _orderListAdmin[i].status == "Đã xác nhận") count++;
    }
    return count;
  }

  int countNoChecked(int userId) {
    int count = 0;
    for (int i = 0; i < _orderListAdmin.length; i++) {
      if (_orderListAdmin[i].userId == userId &&
          _orderListAdmin[i].status == "Chưa xác nhận") count++;
    }
    return count;
  }

  //admin count so luong san pham ban ra
  Future<void> fetchCountAllOrderDetail() async {
    var _fetchAllOrder = OrderService();
    try {
      _countOrderList = await _fetchAllOrder.fetchCountAllOrderDetail();
      notifyListeners();
    } catch (error) {
      print(error);
    }
    print('hihi');
    print(_countSellItem.length);
  }

  double totalPrice() {
    double _total = 0.0;
    for (var order in orderListAdmin) {
      if (order.status == "Đã xác nhận") {
        _total = _total + order.total;
      }
    }
    return _total;
    // print(_total.toString());
  }

  double totalOneItem(int quantity, int price, int discount) {
    double total = ((quantity * price) - (quantity * price * discount / 100));
    return total;
  }

  double totalAllItem(int quantity, int price, int discount) {
    double total = ((quantity * price) - (quantity * price * discount / 100));
    return total;
  }
}
