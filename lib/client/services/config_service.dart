import 'package:mobile_app_3/client/models/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfigService {
  Future<List<ConfigModel>> fetchConfig(int pdId) async {
    List<ConfigModel> configList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/config.php?pdId=$pdId&fetchConfig'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        configList = List<ConfigModel>.from(
            jsonData.map((item) => ConfigModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return configList;
  }

  Future<bool> addConfig(ConfigModel config) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/config.php'),
        body: jsonEncode(
          {
            'config': config.toJson(),
          },
        ),
      );
      if (response.statusCode == 200) {
        print("add config");
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<bool> updateConfig(ConfigModel config) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/config.php'),
        body: jsonEncode(
          {
            'updateConfig': config.toJson(),
          },
        ),
      );
      if (response.statusCode == 200) {
        //    print('hahah');
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }
}
