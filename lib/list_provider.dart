import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './models.dart';
import './categorization_service.dart';

class ListProvider with ChangeNotifier {
  final Map<String, ShoppingList> _shoppingLists = {};
  final Uuid _uuid = const Uuid();

  Map<String, ShoppingList> get shoppingLists => _shoppingLists;

  ShoppingList getlistById(String id) {
    return _shoppingLists[id]!;
  }

  void addList(String name) {
    final id = _uuid.v4();
    _shoppingLists[id] = ShoppingList(id: id, name: name, items: []);
    notifyListeners();
  }

  void removeList(String listId) {
    _shoppingLists.remove(listId);
    notifyListeners();
  }

  void addItem(String listId, String itemName) {
    final item = ShoppingItem(
      id: _uuid.v4(),
      name: itemName,
      category: CategorizationService.categorize(itemName),
    );
    _shoppingLists[listId]?.items.add(item);
    notifyListeners();
  }

  void removeItem(String listId, String itemId) {
    _shoppingLists[listId]?.items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void toggleItemBought(String listId, String itemId, bool isBought) {
    final list = _shoppingLists[listId];
    if (list != null) {
      final item = list.items.firstWhere((item) => item.id == itemId);
      item.isBought = isBought;
      notifyListeners();
    }
  }

  void updateItemName(String listId, String itemId, String newName) {
    final list = _shoppingLists[listId];
    if (list != null) {
      final item = list.items.firstWhere((item) => item.id == itemId);
      item.name = newName;
      item.category = CategorizationService.categorize(newName);
      notifyListeners();
    }
  }

  void updateItemPrice(String listId, String itemId, double newPrice) {
    final list = _shoppingLists[listId];
    if (list != null) {
      final item = list.items.firstWhere((item) => item.id == itemId);
      item.price = newPrice;
      notifyListeners();
    }
  }

  double getTotalCost(String listId) {
    final list = _shoppingLists[listId];
    if (list == null) return 0.0;
    return list.items
        .where((item) => item.isBought)
        .fold(0.0, (sum, item) => sum + item.price);
  }
}
