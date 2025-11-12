import 'package:flutter/material.dart';
import 'package:cart_pal/models.dart';
import 'package:cart_pal/widgets/shopping_list_item_widget.dart';

class ItemListWidget extends StatelessWidget {
  final ShoppingList list;

  const ItemListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.only(bottom: 80), // Add padding to avoid overlap
      itemCount: list.items.length,
      itemBuilder: (context, index) {
        final item = list.items[index];
        return ShoppingListItemWidget(
          key: ValueKey(item.id), // Add a unique key for each item
          list: list,
          item: item,
        );
      },
      onReorder: (oldIndex, newIndex) {
        // Handle reordering logic here if needed
      },
    );
  }
}
