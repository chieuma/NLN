import 'dart:convert';

import 'dart:typed_data';

class CartModel {
  int cartId;
  int cartUserId;
  int pdId;
  String pdName;
  String brandName;
  int cartOptId;
  int optMemory;
  String colorNameVn;
  int optPrice;
  int quantity;
  int cartBuyQuantity;
  List<Uint8List> imageUrl;
  bool checked;

  CartModel({
    required this.cartId,
    required this.cartUserId,
    required this.pdId,
    required this.pdName,
    required this.brandName,
    required this.cartOptId,
    required this.optMemory,
    required this.colorNameVn,
    required this.optPrice,
    required this.quantity,
    required this.cartBuyQuantity,
    required this.imageUrl,
    required this.checked,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    List<String> imageUrlsString = (json['image_url'] as String).split(',  ');

    List<Uint8List> imageList = [];
    for (String imageUrl in imageUrlsString) {
      // Fetch image data from URL or file and convert to Uint8List

      // Convert base64 back to Uint8List
      Uint8List decodedData = base64Decode(imageUrl);

      // Add decoded image data to the list
      imageList.add(decodedData);
    }
    return CartModel(
        cartId: json['cart_id'],
        cartUserId: json['cart_user_id'],
        pdId: json['pd_id'],
        pdName: json['pd_name'],
        brandName: json['brand_name'],
        cartOptId: json['cart_opt_id'],
        optMemory: json['opt_memory'],
        colorNameVn: json['color_name_vn'],
        optPrice: json['opt_price'],
        quantity: json['opt_quantity'],
        cartBuyQuantity: json['cart_buy_quantity'],
        imageUrl: imageList,
        checked: stringToBool(json['cart_checked']));
  }

  Map<String, dynamic> toJson() {
    List<String> base64Images;
    base64Images = imageUrl.map((image) => base64Encode(image)).toList();
    return {
      'cartId': cartId,
      'cartUserId': cartUserId,
      'pdId': pdId,
      'pdName': pdName,
      'brandName': brandName,
      'cartOptId': cartOptId,
      'optMemory': optMemory,
      'colorNameVn': colorNameVn,
      'optPrice': optPrice,
      'quantity': quantity,
      'cartBuyQuantity': cartBuyQuantity,
      'imageUrl': base64Images,
      'checked': checked,
    };
  }
}

bool stringToBool(String stringValue) {
  return stringValue.toLowerCase() == 'true';
}
