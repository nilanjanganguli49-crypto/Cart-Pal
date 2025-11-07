
class ShoppingItem {
  final String id;
  String name;
  String category;
  bool isBought;
  double price;

  ShoppingItem({
    required this.id,
    required this.name,
    this.category = 'Uncategorized',
    this.isBought = false,
    this.price = 0.0,
  });
}

class ShoppingList {
  final String id;
  String name;
  List<ShoppingItem> items;

  ShoppingList({required this.id, required this.name, required this.items});
}
