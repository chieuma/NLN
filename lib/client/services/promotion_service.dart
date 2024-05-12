import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_3/client/models/promotion.dart';

class PromotionService {
  Future<List<PromotionModel>> fetchPromotion() async {
    List<PromotionModel> promotionList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/promotion.php?fetchPromotion'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        promotionList = List<PromotionModel>.from(
            jsonData.map((item) => PromotionModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return promotionList;
  }

  Future<bool> addPromotion(PromotionModel promotion) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/promotion.php'),
        body: jsonEncode(
          {
            "promotion": promotion.toJson(),
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }

  Future<bool> removeOnePromotion(int id) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1/api/client/promotion.php?remove&id=$id'),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }
}
