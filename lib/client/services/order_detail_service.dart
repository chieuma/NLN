// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:mobile_app_3/client/models/order_detail.dart';

// class OrderDetailService {
//   Future<List<OrderDetailModel>> fetchOrderDetail(int userId) async {
//     List<OrderDetailModel> orderList = [];
//     try {
//       final response = await http.get(Uri.parse(
//           'http://192.168.56.1/api/client/order_detail.php?userId=$userId&fetchOrderDetail'));
//       if (response.statusCode == 200) {
//         print(response.body);
//         final jsonData = jsonDecode(response.body);
//         orderList = List<OrderDetailModel>.from(
//             jsonData.map((item) => OrderDetailModel.fromJson(item)));
//       }
//     } catch (error) {
//       print(error);
//     }
//     print('huhu');
//     return orderList;
//   }
// }
