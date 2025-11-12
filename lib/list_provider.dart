import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:convert';
import 'models.dart';

class ListProvider with ChangeNotifier {
  List<ShoppingList> _lists = [];
  static const String _prefsKey = 'shoppingLists';

  List<ShoppingList> get lists => _lists;

  ListProvider() {
    _loadLists();
  }

  Future<void> _loadLists() async {
    final prefs = await SharedPreferences.getInstance();
    final String? listsString = prefs.getString(_prefsKey);
    if (listsString != null) {
      final List<dynamic> listsJson = json.decode(listsString);
      _lists = listsJson.map((json) {
        final List<dynamic> itemsJson = json['items'];
        final items = itemsJson.map((itemJson) {
          return ShoppingItem(
            id: itemJson['id'],
            name: itemJson['name'],
            price: itemJson['price']?.toDouble() ?? 0.0,
            isBought: itemJson['isBought'] ?? false,
            quantity: itemJson['quantity'] ?? 1,
            weight: itemJson['weight'] ?? '',
          );
        }).toList();
        return ShoppingList(id: json['id'], shopName: json['shopName'] ?? json['name'] ?? '', items: items);
      }).toList();
      notifyListeners();
    }
  }

  Future<void> _saveLists() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> listsJson = _lists.map((list) {
      final List<Map<String, dynamic>> itemsJson = list.items.map((item) {
        return {
          'id': item.id,
          'name': item.name,
          'price': item.price,
          'isBought': item.isBought,
          'quantity': item.quantity,
          'weight': item.weight,
        };
      }).toList();
      return {
        'id': list.id,
        'shopName': list.shopName,
        'items': itemsJson,
      };
    }).toList();
    prefs.setString(_prefsKey, json.encode(listsJson));
  }

  void addList(String shopName) {
    final newList = ShoppingList(id: uuid.v4(), shopName: shopName, items: []);
    _lists.add(newList);
    _saveLists();
    notifyListeners();
  }

  void removeList(String listId) {
    _lists.removeWhere((list) => list.id == listId);
    _saveLists();
    notifyListeners();
  }

  ShoppingList getlistById(String id) {
    return _lists.firstWhere((list) => list.id == id);
  }

  void addItem(String listId, String itemName) {
    final listIndex = _lists.indexWhere((list) => list.id == listId);
    final newItem = ShoppingItem(id: uuid.v4(), name: itemName);
    _lists[listIndex].items.add(newItem);
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'add_item',
    //   parameters: {
    //     'list_id': listId,
    //     'item_name': itemName,
    //   },
    // );
    _saveLists();
    notifyListeners();
  }

  void removeItem(String listId, String itemId) {
    final listIndex = _lists.indexWhere((list) => list.id == listId);
    _lists[listIndex].items.removeWhere((item) => item.id == itemId);
    _saveLists();
    notifyListeners();
  }

  void updateItemName(String listId, String itemId, String newName) {
    final listIndex = _lists.indexWhere((list) => list.id == listId);
    final itemIndex = _lists[listIndex].items.indexWhere((item) => item.id == itemId);
    _lists[listIndex].items[itemIndex] = _lists[listIndex].items[itemIndex].copyWith(name: newName);
    _saveLists();
    notifyListeners();
  }

  void updateItemPrice(String listId, String itemId, double newPrice) {
    final listIndex = _lists.indexWhere((list) => list.id == listId);
    final itemIndex = _lists[listIndex].items.indexWhere((item) => item.id == itemId);
    _lists[listIndex].items[itemIndex] = _lists[listIndex].items[itemIndex].copyWith(price: newPrice);
    _saveLists();
    notifyListeners();
  }

  void updateItemQuantity(String listId, String itemId, int newQuantity) {
    final listIndex = _lists.indexWhere((list) => list.id == listId);
    final itemIndex = _lists[listIndex].items.indexWhere((item) => item.id == itemId);
    _lists[listIndex].items[itemIndex] = _lists[listIndex].items[itemIndex].copyWith(quantity: newQuantity);
    _saveLists();
    notifyListeners();
  }

  void updateItemWeight(String listId, String itemId, String newWeight) {
    final listIndex = _lists.indexWhere((list) => list.id == listId);
    final itemIndex = _lists[listIndex].items.indexWhere((item) => item.id == itemId);
    _lists[listIndex].items[itemIndex] = _lists[listIndex].items[itemIndex].copyWith(weight: newWeight);
    _saveLists();
    notifyListeners();
  }


  void toggleItemBought(String listId, String itemId, bool isBought) {
    final listIndex = _lists.indexWhere((list) => list.id == listId);
    final itemIndex = _lists[listIndex].items.indexWhere((item) => item.id == itemId);
    _lists[listIndex].items[itemIndex] = _lists[listIndex].items[itemIndex].copyWith(isBought: isBought);
    _saveLists();
    notifyListeners();
  }

  double getTotalCost(String listId) {
    final list = getlistById(listId);
    return list.items.where((item) => item.isBought).fold(0.0, (total, item) => total + (item.price * item.quantity));
  }
}
