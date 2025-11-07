import 'package:flutter/material.dart';
import './models.dart';
import './categorization_service.dart';

class ListProvider with ChangeNotifier {
  final List<ShoppingList> _shoppingLists = [];

  List<ShoppingList> get shoppingLists => _shoppingLists;

  void addList(ShoppingList list) {
    _shoppingLists.add(list);
    notifyListeners();
  }

  void removeList(ShoppingList list) {
    _shoppingLists.remove(list);
    notifyListeners();
  }

  void addItem(ShoppingList list, ShoppingItem item) {
    item.category = CategorizationService.categorize(item.name);
    list.items.add(item);
    notifyListeners();
  }

  void removeItem(ShoppingList list, ShoppingItem item) {
    list.items.remove(item);
    notifyListeners();
  }

  void toggleItem(ShoppingList list, ShoppingItem item) {
    item.isChecked = !item.isChecked;
    notifyListeners();
  }

  void updateItemColor(ShoppingList list, ShoppingItem item, Color newColor) {
    item.color = newColor;
    notifyListeners();
  }

  void updateItemPrice(ShoppingList list, ShoppingItem item, double newPrice) {
    item.price = newPrice;
    notifyListeners();
  }

  double getTotalCost(ShoppingList list) {
    return list.items
        .where((item) => item.isChecked)
        .fold(0.0, (sum, item) => sum + item.price);
  }
}
