import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../list_provider.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/item_list_widget.dart';

class ShoppingListScreen extends StatelessWidget {
  final String listId;

  const ShoppingListScreen({super.key, required this.listId, required int listIndex});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);
    final shoppingList = listProvider.getlistById(listId);

    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddItemDialog(context, listProvider, shoppingList.id),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ItemListWidget(list: shoppingList),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Cost:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Consumer<ListProvider>(
                  builder: (context, listProvider, child) {
                    return Text(
                      '\$${listProvider.getTotalCost(shoppingList.id).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  },
                ),
              ],
            ),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }

  void _showAddItemDialog(
    BuildContext context,
    ListProvider listProvider,
    String listId,
  ) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Item Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  listProvider.addItem(listId, controller.text);
                  Navigator.of(context).pop();
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
