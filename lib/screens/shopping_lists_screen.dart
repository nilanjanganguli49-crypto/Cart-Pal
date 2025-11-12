import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../list_provider.dart';

class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);
    final shoppingLists = listProvider.lists;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Shopping Lists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController nameController = TextEditingController();
                  return AlertDialog(
                    title: const Text('New Shopping List'),
                    content: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Shop Name'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            listProvider.addList(nameController.text);
                            context.pop();
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: shoppingLists.length,
        itemBuilder: (context, index) {
          final list = shoppingLists[index];
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text(list.shopName),
            onTap: () {
              context.go('/list/${list.id}');
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                listProvider.removeList(list.id);
              },
            ),
          );
        },
      ),
    );
  }
}
