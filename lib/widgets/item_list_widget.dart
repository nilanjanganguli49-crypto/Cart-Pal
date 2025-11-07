
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../list_provider.dart';
import '../models.dart';

class ItemListWidget extends StatefulWidget {
  final ShoppingList list;

  const ItemListWidget({super.key, required this.list});

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  late Map<String, TextEditingController> _priceControllers;
  late Map<String, TextEditingController> _nameControllers;

  @override
  void initState() {
    super.initState();
    _priceControllers = {
      for (var item in widget.list.items)
        item.id: TextEditingController(text: item.price.toString())
    };
    _nameControllers = {
      for (var item in widget.list.items)
        item.id: TextEditingController(text: item.name)
    };
  }

  @override
  void didUpdateWidget(covariant ItemListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.list != oldWidget.list) {
      _priceControllers.forEach((_, controller) => controller.dispose());
      _nameControllers.forEach((_, controller) => controller.dispose());
      _priceControllers = {
        for (var item in widget.list.items)
          item.id: TextEditingController(text: item.price.toString())
      };
      _nameControllers = {
        for (var item in widget.list.items)
          item.id: TextEditingController(text: item.name)
      };
    }
  }

  @override
  void dispose() {
    _priceControllers.forEach((_, controller) => controller.dispose());
    _nameControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.list.items.length,
      itemBuilder: (context, index) {
        final item = widget.list.items[index];
        final priceController = _priceControllers[item.id]!;
        final nameController = _nameControllers[item.id]!;

        return ListTile(
          leading: Checkbox(
            value: item.isBought,
            onChanged: (bool? value) {
              listProvider.toggleItemBought(widget.list.id, item.id, value!);
            },
          ),
          title: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (value) {
              listProvider.updateItemName(widget.list.id, item.id, value);
            },
          ),
          trailing: SizedBox(
            width: 80,
            child: TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixText: '\$',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                final price = double.tryParse(value) ?? 0.0;
                listProvider.updateItemPrice(widget.list.id, item.id, price);
              },
            ),
          ),
          onLongPress: () {
            listProvider.removeItem(widget.list.id, item.id);
          },
        );
      },
    );
  }
}
