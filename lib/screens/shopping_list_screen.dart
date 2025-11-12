import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../list_provider.dart';
import '../models.dart';
import '../widgets/item_list_widget.dart';

class ShoppingListScreen extends StatelessWidget {
  final String listId;

  const ShoppingListScreen({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);
    final ShoppingList list = listProvider.getlistById(listId);

    return Scaffold(
      appBar: AppBar(
        title: Text(list.shopName),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddItemDialog(context, listProvider, listId);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ItemListWidget(list: list),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: Text(
                'Total: ₹${listProvider.getTotalCost(listId).toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog(
      BuildContext context, ListProvider listProvider, String listId) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Item Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  listProvider.addItem(listId, controller.text);
                  context.pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
