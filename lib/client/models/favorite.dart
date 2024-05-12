import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavoriteModel with ChangeNotifier {
  final int favPdId;
  final int productId;
  final String productName;

  final List<String> colorName;
  final List<String> memoryOptions;
  final List<String> priceOptions;
  final List<Uint8List> imageUrls;

  FavoriteModel({
    required this.favPdId,
    required this.productId,
    required this.productName,
    required this.colorName,
    required this.memoryOptions,
    required this.priceOptions,
    required this.imageUrls,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    List<String> imageUrlsString = (json['Image_URLs'] as String).split(',  ');

    List<Uint8List> imageList = [];
    for (String imageUrl in imageUrlsString) {
      // Fetch image data from URL or file and convert to Uint8List

      // Convert base64 back to Uint8List
      Uint8List decodedData = base64Decode(imageUrl);

      // Add decoded image data to the list
      imageList.add(decodedData);
    }
    return FavoriteModel(
      favPdId: json['Fav_Pd_Id'],
      productId: json['Product_ID'],
      productName: json['Product_Name'],
      colorName: (json['Colors'] as String).split(', '),
      memoryOptions: (json['Memory_Options'] as String).split(', '),
      priceOptions: (json['Price_Options'] as String).split(', '),
      imageUrls: imageList,
    );
  }
}
