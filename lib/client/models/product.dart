import 'dart:convert';
import 'dart:typed_data';

class ProductModel {
  final int? productId;
  late final String productName;
  final String brand;

  final List<String>? colorName;
  final List<String>? memoryOptions;
  final List<String>? priceOptions;
  // late List<Uint8List>? imageUrls;
  late List<Uint8List>? imageUrls;
  int? categoryId;

  ProductModel({
    this.productId,
    required this.productName,
    required this.brand,
    this.colorName,
    this.memoryOptions,
    this.priceOptions,
    this.imageUrls,
    this.categoryId,
  });

  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   // List<Uint8List> decodedImages = [];
  //   // if (json['Image_URLs'] != null) {
  //   //   if (json['Image_URLs'] is String) {
  //   //     String imageUrlString = json['Image_URLs'] as String;
  //   //     decodedImages.add(base64Decode(imageUrlString));
  //   //   } else if (json['Image_URLs'] is List<dynamic>) {
  //   //     List<dynamic> imageUrlList = json['Image_URLs'] as List<dynamic>;
  //   //     decodedImages = imageUrlList.map((url) {
  //   //       return base64Decode(url.toString());
  //   //     }).toList();
  //   //   }
  //   // }

  //   return ProductModel(
  //     productId: json['Product_ID'],
  //     productName: json['Product_Name'],
  //     brand: json['Product_brand'],
  //     colorName: (json['Colors'] as String).split(', '),
  //     memoryOptions: (json['Memory_Options'] as String).split(', '),
  //     priceOptions: (json['Price_Options'] as String).split(', '),
  //     // imageUrls: decodedImages,
  //     imageUrls: (json['Image_URLs'] as String).split(', '),
  //   );
  // }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> imageUrlsString = (json['Image_URLs'] as String).split(',  ');

    List<Uint8List> imageList = [];
    for (String imageUrl in imageUrlsString) {
      // Fetch image data from URL or file and convert to Uint8List

      // Convert base64 back to Uint8List
      Uint8List decodedData = base64Decode(imageUrl);

      // Add decoded image data to the list
      imageList.add(decodedData);
    }

    return ProductModel(
      productId: json['Product_ID'],
      productName: json['Product_Name'],
      brand: json['Product_brand'],
      colorName: (json['Colors'] as String).split(', '),
      memoryOptions: (json['Memory_Options'] as String).split(', '),
      priceOptions: (json['Price_Options'] as String).split(', '),
      imageUrls: imageList,
      categoryId: json['idCategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'brand': brand,
    };
  }
}
