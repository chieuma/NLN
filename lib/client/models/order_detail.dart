import 'dart:convert';
import 'dart:typed_data';

class OrderDetailModel {
  final int? odId;
  final int? orderId;
  final int odQuantity;
  final Uint8List odImage;
  final String odPdName;
  final double odPdPrice;
  final String odPdMemory;
  final String odPdColor;
  final int odOptId;

  OrderDetailModel({
    this.odId,
    this.orderId,
    required this.odQuantity,
    required this.odImage,
    required this.odPdName,
    required this.odPdPrice,
    required this.odPdMemory,
    required this.odPdColor,
    required this.odOptId,
  });

  static OrderDetailModel fromJson(Map<String, dynamic> json) {
    String imageUrlsString = json['order_detail_image'];
    Uint8List decodedData = base64Decode(imageUrlsString);

    return OrderDetailModel(
      odId: json['order_detail_id'],
      orderId: json['order_detail_order_id'],
      odQuantity: json['order_detail_quantity'],
      odImage: decodedData,
      odPdName: json['order_detail_pd_name'],
      odPdPrice: json['order_detail_price'].toDouble(),
      odPdMemory: json['order_detail_memory'],
      odPdColor: json['order_detail_color_vn'],
      odOptId: json['order_detail_opt_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'odQuantity': odQuantity,
      'odImage': odImage,
      'odPdName': odPdName,
      'odPdPrice': odPdPrice,
      'odPdMemory': odPdMemory,
      'odPdColor': odPdColor,
      'odOptId': odOptId,
    };
  }
}
