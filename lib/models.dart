import 'package:flutter/material.dart';

class ShoppingItem {
  String name;
  String quantity;
  String category;
  bool isChecked;
  Color color;
  double price;

  ShoppingItem({
    required this.name,
    this.quantity = '1',
    this.category = 'Uncategorized',
    this.isChecked = false,
    this.color = Colors.transparent,
    this.price = 0.0,
  });
}

class ShoppingList {
  String name;
  List<ShoppingItem> items;

  ShoppingList({required this.name, required this.items});
}
