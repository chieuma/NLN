import 'dart:convert';
import 'dart:typed_data';

class ProductSellModel {
  final String name;
  final Uint8List image;
  final int price;
  final int memory;
  final String colorVn;
  final int count;

  ProductSellModel({
    required this.name,
    required this.image,
    required this.price,
    required this.memory,
    required this.colorVn,
    required this.count,
  });

  static int parseDynamicToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0; // Trả về giá trị mặc định nếu không phải là int hoặc String
    }
  }

  static ProductSellModel fromJson(Map<dynamic, dynamic> json) {
    String imageUrlsString = json['order_detail_image'];
    Uint8List decodedData = base64Decode(imageUrlsString);
    return ProductSellModel(
      name: json['order_detail_pd_name'],
      image: decodedData,
      price: parseDynamicToInt(json['order_detail_price']),
      memory: parseDynamicToInt(json['order_detail_memory']),
      colorVn: json['order_detail_color_vn'],
      count: parseDynamicToInt(json['count']),
    );
  }
}
