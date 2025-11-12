import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../list_provider.dart';
import '../models.dart';

class ShoppingListItemWidget extends StatefulWidget {
  final ShoppingList list;
  final ShoppingItem item;

  const ShoppingListItemWidget(
      {super.key, required this.list, required this.item});

  @override
  State<ShoppingListItemWidget> createState() => _ShoppingListItemWidgetState();
}

class _ShoppingListItemWidgetState extends State<ShoppingListItemWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  late final TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _priceController = TextEditingController(text: widget.item.price.toString());
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    _weightController = TextEditingController(text: widget.item.weight);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ShoppingListItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.name != oldWidget.item.name &&
        widget.item.name != _nameController.text) {
      _nameController.text = widget.item.name;
    }
    if (widget.item.price != oldWidget.item.price &&
        widget.item.price.toString() != _priceController.text) {
      _priceController.text = widget.item.price.toString();
    }
    if (widget.item.quantity != oldWidget.item.quantity &&
        widget.item.quantity.toString() != _quantityController.text) {
      _quantityController.text = widget.item.quantity.toString();
    }
    if (widget.item.weight != oldWidget.item.weight &&
        widget.item.weight != _weightController.text) {
      _weightController.text = widget.item.weight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context, listen: false);

    return ListTile(
      leading: Checkbox(
        value: widget.item.isBought,
        onChanged: (bool? value) {
          listProvider.toggleItemBought(widget.list.id, widget.item.id, value!);
        },
      ),
      title: TextFormField(
        controller: _nameController,
        decoration: const InputDecoration(border: InputBorder.none),
        style: TextStyle(
          decoration: widget.item.isBought
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
        onFieldSubmitted: (value) {
          if (value.isNotEmpty && value != widget.item.name) {
            listProvider.updateItemName(widget.list.id, widget.item.id, value);
          } else {
            _nameController.text = widget.item.name;
          }
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 80,
            child: TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Weight'),
              onFieldSubmitted: (value) {
                listProvider.updateItemWeight(
                    widget.list.id, widget.item.id, value);
              },
            ),
          ),
          SizedBox(
            width: 80,
            child: TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(
                  border: InputBorder.none, prefixText: 'Qty: '),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                final quantity = int.tryParse(value) ?? 1;
                listProvider.updateItemQuantity(
                    widget.list.id, widget.item.id, quantity);
              },
            ),
          ),
          SizedBox(
            width: 80,
            child: TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixText: '₹',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onFieldSubmitted: (value) {
                final price = double.tryParse(value) ?? 0.0;
                if (price != widget.item.price) {
                  listProvider.updateItemPrice(
                      widget.list.id, widget.item.id, price);
                }
              },
            ),
          ),
        ],
      ),
      onLongPress: () {
        listProvider.removeItem(widget.list.id, widget.item.id);
      },
    );
  }
}
