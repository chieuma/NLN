import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_3/client/models/brand.dart';

class BrandService {
  Future<List<BrandModel>> fetchBrand() async {
    List<BrandModel> brandList = [];
    try {
      final response = await http.get(
          Uri.parse('http://192.168.56.1/api/client/brand.php?fetchBrand'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        brandList = List<BrandModel>.from(
            jsonData.map((item) => BrandModel.fromJson(item)));
      }
      for (BrandModel brand in brandList) {
        print(brand.name);
      }
    } catch (error) {
      print(error);
    }
    return brandList;
  }

  Future<bool> addBrand(int id, String name) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/brand.php'),
        body: jsonEncode(
          {
            "nameBrand": name,
            "id": id,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 500) {
        return false;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> removeBrand(int id) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/brand.php?removeBrand&id=$id'));
      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 500) {
        return false;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }
}
