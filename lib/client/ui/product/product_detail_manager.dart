import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/cart.dart';
import 'package:mobile_app_3/client/models/order.dart';
import 'package:mobile_app_3/client/models/order_1item.dart';
import 'package:mobile_app_3/client/models/order_detail.dart';
import 'package:mobile_app_3/client/models/product_detail.dart';
import 'package:mobile_app_3/client/services/order_service.dart';
import 'package:mobile_app_3/client/ui/order/order_manager.dart';
import '../../services/product_service.dart';

class ProductDetailManager with ChangeNotifier {
  List<ProductDetailModel> _product = [];

  List<ProductDetailModel> get product => _product;

  Future<List<ProductDetailModel>> fetchPhoneDetail(int id) async {
    var _fetchProduct = ProductSerivce();
    try {
      _product = await _fetchProduct.fetchPhoneDetail(id);
      print(_product.length);
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _product;
  }

  // Khi thanh toán thì cập nhật lại sô lượng ở trang chi tiết sản phẩm
  Future<void> addOrder(OrderModel order, List<CartModel> carts) async {
    var _orderService = OrderService();
    for (var cart in carts) {
      for (var product in _product) {
        for (var i = 0; i < product.opt!.length; i++) {
          if (product.opt![i] == cart.cartOptId.toString()) {
            // Opt trùng khớp, cập nhật lại quantity
            var quantity = int.tryParse(product.quantityOptions[i]);
            if (quantity != null) {
              product.quantityOptions[i] =
                  (quantity - cart.cartBuyQuantity).toString();
              notifyListeners(); // Thông báo cho người nghe
              break; // Thoát khỏi vòng lặp sau khi cập nhật
            }
          }
        }
      }
    }
    await _orderService.addOrder(order, carts);
  }

  Future<void> add1Order(OrderModel order, Order1ItemModel order1item) async {
    var _orderService = OrderService();

    for (var product in _product) {
      for (var i = 0; i < product.opt!.length; i++) {
        if (product.opt![i] == order1item.optId.toString()) {
          // Opt trùng khớp, cập nhật lại quantity
          var quantity = int.tryParse(product.quantityOptions[i]);
          if (quantity != null) {
            product.quantityOptions[i] =
                (quantity - order1item.quantity).toString();
            notifyListeners(); // Thông báo cho người nghe
            break; // Thoát khỏi vòng lặp sau khi cập nhật
          }
        }
      }
    }
    await _orderService.add1Order(order, order1item);
  }

  Future<void> removeOrder(
      OrderModel order, List<OrderDetailModel> orderDetail) async {
    var _orderSerivce = OrderService();
    for (var order in orderDetail) {
      for (var product in _product) {
        for (var i = 0; i < product.opt!.length; i++) {
          if (product.opt![i] == order.odOptId.toString()) {
            // Opt trùng khớp, cập nhật lại quantity
            var quantity = int.tryParse(product.quantityOptions[i]);
            if (quantity != null) {
              product.quantityOptions[i] =
                  (quantity + order.odQuantity).toString();
              notifyListeners();
              break;
            }
          }
        }
      }
    }
    await _orderSerivce.removeOrder(order, orderDetail);
    notifyListeners();
  }

}
