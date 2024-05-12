import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/config.dart';
import 'package:mobile_app_3/client/services/config_service.dart';

class ConfigManager with ChangeNotifier {
  List<ConfigModel> _config = [];
  List<ConfigModel> get config => _config;
  Future<List<ConfigModel>> fetchConfig(int pdId) async {
    var _configService = ConfigService();
    try {
      _config = await _configService.fetchConfig(pdId);

      notifyListeners();
    } catch (error) {
      print(error);
    }
    print(_config.length);
    return _config;
  }

  Future<bool> addConfig(ConfigModel config) async {
    var _configService = ConfigService();
    try {
      if (await _configService.addConfig(config)) {
        _config.add(config);
        notifyListeners();
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  Future<bool> updateConfig(ConfigModel config) async {
    var _configService = ConfigService();
    try {
      if (await _configService.updateConfig(config)) {
        int index =
            _config.indexWhere((element) => element.pdId == config.pdId);
        if (index >= 0) {
          _config.removeAt(index);
          _config.add(config);
          notifyListeners();
        }
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }
}
