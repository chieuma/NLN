import 'dart:convert';
import 'dart:typed_data';

class Order1ItemModel {
  final int productId;
  final String name;
  final Uint8List? imageUrl;
  final String colorVn;
  final int memory;
  final int price;
  final int quantity;
  final int optId;

  Order1ItemModel({
    required this.productId,
    required this.name,
    this.imageUrl,
    required this.colorVn,
    required this.memory,
    required this.price,
    required this.quantity,
    required this.optId,
  });

  Map<String, dynamic> toJson() {
    // Chuyển đổi Uint8List thành chuỗi base64 nếu imageUrl khác null
    String? base64Image = imageUrl != null ? base64Encode(imageUrl!) : null;
    return {
      'imageUrl': base64Image,
      'pdName': name,
      'colorNameVn': colorVn,
      'optMemory': memory,
      'optPrice': price,
      'cartBuyQuantity': quantity,
      'cartOptId': optId,
    };
  }
}
