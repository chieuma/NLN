// Option
import 'dart:convert';
import 'dart:typed_data';

class ProductDetailModel {
  final int? productId;
  final String? productName;
  final String? brand;
  final String? category;
  final String? colorName;
  final String? colorNameVn;
  final int? colorId;
  final List<String>? opt;
  final List<String>? imageId;
  final List<String> memoryOptions;
  final List<String> priceOptions;
  final List<String> quantityOptions;
  late List<Uint8List>? imageUrls;

  ProductDetailModel({
    this.productId,
    this.productName,
    this.brand,
    this.category,
    this.colorName,
    this.colorNameVn,
    this.colorId,
    this.opt,
    this.imageId,
    required this.memoryOptions,
    required this.priceOptions,
    required this.quantityOptions,
    this.imageUrls,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    List<String> imageUrlsString = (json['Image_Urls'] as String).split(',  ');

    List<Uint8List> imageList = [];
    for (String imageUrl in imageUrlsString) {
      // Fetch image data from URL or file and convert to Uint8List

      // Convert base64 back to Uint8List
      Uint8List decodedData = base64Decode(imageUrl);

      // Add decoded image data to the list
      imageList.add(decodedData);
    }
    return ProductDetailModel(
      productId: json['Product_ID'],
      productName: json['Product_Name'],
      brand: json['Brand'],
      category: json['Category'],
      colorName: json['Color_Name'],
      colorNameVn: json['Color_Name_Vn'],
      colorId: json['Color_Id'],
      opt: (json['Opt'] as String).split(', '),
      imageId: (json['ImageId'] as String).split(', '),
      memoryOptions: (json['Memory_Options'] as String).split(', '),
      priceOptions: (json['Price_Options'] as String).split(', '),
      quantityOptions: (json['Quantity_Options'] as String).split(', '),
      imageUrls: imageList,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'memoryOptions': memoryOptions,
      'priceOptions': priceOptions,
      'quantityOptions': quantityOptions,
      'imageUrls': imageUrls,
    };
  }

  Map<String, dynamic> toJsonEdit() {
    return {
      'opt': opt,
      'imageId': imageId,
      'colorName': colorName,
      'colorNameVn': colorNameVn,
      'colorId': colorId,
      'memoryOptions': memoryOptions,
      'priceOptions': priceOptions,
      'quantityOptions': quantityOptions,
    };
  }
}
