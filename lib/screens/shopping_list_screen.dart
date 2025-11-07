import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../list_provider.dart';
import '../models.dart';

class ShoppingListScreen extends StatelessWidget {
  final int listIndex;

  const ShoppingListScreen({super.key, required this.listIndex});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);
    final shoppingList = listProvider.shoppingLists[listIndex];

    final Map<String, List<ShoppingItem>> itemsByCategory = {};
    for (var item in shoppingList.items) {
      if (!itemsByCategory.containsKey(item.category)) {
        itemsByCategory[item.category] = [];
      }
      itemsByCategory[item.category]!.add(item);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: ListView.builder(
        itemCount: itemsByCategory.length,
        itemBuilder: (context, index) {
          final category = itemsByCategory.keys.elementAt(index);
          final items = itemsByCategory[category]!;
          return ExpansionTile(
            title: Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: items.map((item) {
              return ListTile(
                tileColor: item.color,
                title: Text(item.name, style: TextStyle(decoration: item.isChecked ? TextDecoration.lineThrough : null)),
                leading: Checkbox(
                  value: item.isChecked,
                  onChanged: (value) {
                    listProvider.toggleItem(shoppingList, item);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<Color>(
                      value: item.color,
                      onChanged: (Color? newColor) {
                        if (newColor != null) {
                          listProvider.updateItemColor(shoppingList, item, newColor);
                        }
                      },
                      items: [Colors.transparent, Colors.blue, Colors.green, Colors.yellow, Colors.red]
                          .map<DropdownMenuItem<Color>>((Color color) {
                        return DropdownMenuItem<Color>(
                          value: color,
                          child: Container(
                            width: 20,
                            height: 20,
                            color: color,
                          ),
                        );
                      }).toList(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        listProvider.removeItem(shoppingList, item);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context, listProvider, shoppingList),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context, ListProvider listProvider, ShoppingList shoppingList) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Item'),
          content: TextField(
            controller: controller,
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
                  listProvider.addItem(shoppingList, ShoppingItem(name: controller.text));
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
