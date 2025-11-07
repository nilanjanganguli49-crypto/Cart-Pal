import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../list_provider.dart';
import '../models.dart';

class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Shopping Lists'),
      ),
      body: ListView.builder(
        itemCount: listProvider.shoppingLists.length,
        itemBuilder: (context, index) {
          final list = listProvider.shoppingLists[index];
          return ListTile(
            title: Text(list.name),
            onTap: () => context.go('/list/$index'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                listProvider.removeList(list);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddListDialog(context, listProvider),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  void _showAddListDialog(BuildContext context, ListProvider listProvider) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Shopping List'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'List Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  listProvider.addList(
                    ShoppingList(name: controller.text, items: []),
                  );
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
