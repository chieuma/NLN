import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:mobile_app_3/client/models/order_detail.dart';
import 'package:mobile_app_3/client/services/order_detail_service.dart';
import 'package:mobile_app_3/client/services/order_service.dart';

class OrderDetailManager with ChangeNotifier {
  List<OrderDetailModel> _orderDetailList = [];
  List<OrderDetailModel> get orderDetailList => _orderDetailList;

  List<OrderDetailModel> _orderList = [];
  List<OrderDetailModel> get orderList => _orderList;

  //fetch trong lich du dat hang
  Future<void> fetchOrderDetail(int userId) async {
    var _fetchOrder = OrderService();
    try {
      _orderDetailList = await _fetchOrder.fetchOrderDetail(userId);
      notifyListeners();
    } catch (error) {
      print(error);
    }
    print(_orderDetailList.length);
  }

  Future<void> updateOrderDetail(List<OrderDetailModel> orderDetail) async {
    try {
      for (int i = 0; i < orderDetail.length; i++) {
        for (int y = 0; y < _orderDetailList.length; i++) {
          if (orderDetail[i].odId! == _orderDetailList[y].odOptId) {
            _orderDetailList.removeAt(y);
            notifyListeners();
          }
        }
      }
    } catch (error) {
      print(error);
    }
  }

  // admin
  Future<void> fetchAllDetailOrder(int orderId) async {
    var _fetchOrder = OrderService();
    try {
      _orderList = await _fetchOrder.fetchAllDetailOrder(orderId);
      notifyListeners();
    } catch (error) {
      print(error);
    }
    print(_orderDetailList.length);
  }
}
