import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/promotion.dart';
import 'package:mobile_app_3/client/services/promotion_service.dart';

class PromotionManager with ChangeNotifier {
  List<PromotionModel> _itemAllPromotion = [];
  List<PromotionModel> get itemAllPromotion => _itemAllPromotion;

  Future<List<PromotionModel>> fetchPromotion() async {
    var _promotionService = PromotionService();
    try {
      _itemAllPromotion = await _promotionService.fetchPromotion();
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return _itemAllPromotion;
  }

  Future<bool> addPromotion(PromotionModel promotion) async {
    var _promotion = PromotionService();
    try {
      if (await _promotion.addPromotion(promotion)) {
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }

  Future<bool> removeOnePromotion(int id) async {
    var _promotion = PromotionService();
    try {
      int index =
          await _itemAllPromotion.indexWhere((element) => element.id! == id);
      //print(index);
      if (index >= 0) {
        await _promotion.removeOnePromotion(id);
        _itemAllPromotion.removeAt(index);
        notifyListeners();
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }
}
