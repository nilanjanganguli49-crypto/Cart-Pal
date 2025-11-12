import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class ShoppingItem {
  final String id;
  final String name;
  final double price;
  final bool isBought;
  final int quantity;
  final String weight;

  ShoppingItem({
    required this.id,
    required this.name,
    this.price = 0.0,
    this.isBought = false,
    this.quantity = 1,
    this.weight = '',
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    double? price,
    bool? isBought,
    int? quantity,
    String? weight,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isBought: isBought ?? this.isBought,
      quantity: quantity ?? this.quantity,
      weight: weight ?? this.weight,
    );
  }
}

class ShoppingList {
  final String id;
  final String shopName;
  final List<ShoppingItem> items;

  ShoppingList({
    required this.id,
    required this.shopName,
    required this.items,
  });

  ShoppingList copyWith({
    String? id,
    String? shopName,
    List<ShoppingItem>? items,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      items: items ?? this.items,
    );
  }
}
