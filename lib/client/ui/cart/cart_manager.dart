import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/cart.dart';
import 'package:mobile_app_3/client/services/cart_service.dart';

class CartManager with ChangeNotifier {
  List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;

  List<CartModel> _cartChecked = [];
  List<CartModel> get cartChecked => _cartChecked;

  get productCount => null;

  Future<List<CartModel>> fetchCart(int userId) async {
    var _fetchCart = CartService();
    try {
      _cart = await _fetchCart.fetchCart(userId);
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _cart;
  }

  int countItem() {
    return _cart.length;
  }

// thêm sản phẩm từ chi tiết sản phẩm
  void addItemToCart(int userId, int opt, int quantity) async {
    var _cartService = CartService();
    bool itemExists =
        _cart.any((item) => item.cartUserId == userId && item.cartOptId == opt);

    if (itemExists) {
      CartModel existingItem = _cart.firstWhere(
          (item) => item.cartUserId == userId && item.cartOptId == opt);

      // Tính toán số lượng mới
      int newQuantity = existingItem.cartBuyQuantity + quantity;
      if (newQuantity <= existingItem.quantity) {
        existingItem.quantity = newQuantity;
        await _cartService.updateQuantityOpt(existingItem.cartId, newQuantity);
        fetchCart(userId);
      } else {
        print('Số lượng mới vượt quá số lượng có sẵn trong kho.');
      }
    } else {
      await _cartService.addItemToCart(userId, opt, quantity);
      fetchCart(userId);
    }
    notifyListeners();
  }

  void removeOneItem(int cartId, int userId) async {
    _cart.removeWhere((item) => item.cartId == cartId);
    var _cartService = CartService();
    await _cartService.removeOneItem(cartId);
    notifyListeners();
    await fetchCart(userId);
  }

// Cập nhật lại số lượng sản phẩm tại cart
  void updateQuantity(int cart_id, int userId) async {
    var _cartService = CartService();
    bool itemExists = _cart
        .any((item) => item.cartUserId == userId && item.cartId == cart_id);
    if (itemExists) {
      CartModel existingItem =
          _cart.firstWhere((item) => item.cartId == cart_id);
      int newQuantity = existingItem.cartBuyQuantity + 1;
      if (newQuantity <= existingItem.quantity) {
        await _cartService.updateQuantity(existingItem.cartId);
        fetchCart(userId);
      } else {
        print('Số lượng mới vượt quá số lượng có sẵn trong kho.');
      }
    } else {
      print('Lỗi');
    }
  }

  // Xoa tat ca san pham trong gio hang
  void removeAllItem(int userId) async {
    var _cartService = CartService();
    await _cartService.removAllItem(userId);
    _cart = [];
    fetchCart(userId);
    notifyListeners();
  }

  void removeQuantity(int cartId, int userId) async {
    var _cartService = CartService();
    bool itemExists =
        _cart.any((item) => item.cartUserId == userId && item.cartId == cartId);
    if (itemExists) {
      CartModel existingItem =
          _cart.firstWhere((item) => item.cartId == cartId);
      int newQuantity = existingItem.cartBuyQuantity - 1;
      if (newQuantity > 0) {
        await _cartService.removeQuantity(existingItem.cartId);
        fetchCart(userId);
      } else {
        print('Số lượng mới vượt quá số lượng có sẵn trong kho.');
      }
    } else {
      print('Lỗi');
    }
    notifyListeners();
  }

  int get total {
    int total = 0;
    for (var pd in _cart) {
      if (pd.checked) total = total + (pd.cartBuyQuantity * pd.optPrice);
    }
    print(total);
    return total;
  }

  Future<void> check(int index, int cartId) async {
    var _cartService = CartService();
    _cart[index].checked = !_cart[index].checked;
    await _cartService.check(cartId, _cart[index].checked.toString());
    notifyListeners();
  }

  double totalChecked(int discount, int condition) {
    double totalChecked = 0;
    for (var cart in _cart) {
      if (cart.checked == true) {
        totalChecked = totalChecked + (cart.cartBuyQuantity * cart.optPrice);
      }
    }
    if (totalChecked >= condition) {
      totalChecked = totalChecked - (totalChecked * discount / 100);
    }
    return totalChecked;
  }

  List<CartModel> fetchCartCheck() {
    _cartChecked = _cart.where((item) => item.checked).toList();
    notifyListeners();
    return _cartChecked;
  }
}
