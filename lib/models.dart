
class ShoppingItem {
  String name;
  String quantity;
  String category;
  bool isChecked;

  ShoppingItem({
    required this.name,
    this.quantity = '1',
    this.category = 'Uncategorized',
    this.isChecked = false,
  });
}

class ShoppingList {
  String name;
  List<ShoppingItem> items;

  ShoppingList({
    required this.name,
    required this.items,
  });
}
