import 'package:flutter/material.dart';
import 'package:latihan_mobile_backend/m03/shopping_list.dart';

class ListProductProvider extends ChangeNotifier {
  List<ShoppingList> _shoppingList = [];

  List<ShoppingList> get getShoppingList => _shoppingList;
  set setShoppingList(value) {
    _shoppingList = value;
    notifyListeners();
  }

  void deleteById(id) {
    _shoppingList.removeWhere((map) => map.id == id);
    notifyListeners();
  }

  void deleteAll() {
    _shoppingList = [];
    notifyListeners();
  }
}
