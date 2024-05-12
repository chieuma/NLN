import '../../client/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryService {
  Future<List<CategoryModel>> fetchCategory() async {
    List<CategoryModel> categoryList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/product.php?name=category'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        categoryList = List<CategoryModel>.from(
            jsonData.map((item) => CategoryModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return categoryList;
  }

  Future<bool> addCategory(name) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/product.php'),
        body: jsonEncode(
          {
            "nameCategory": name,
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

  Future<bool> removeCategory(int id) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/product.php?removeCategory&id=$id'));
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
