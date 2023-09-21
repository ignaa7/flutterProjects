import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/grocery_item_widget.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class ItemsList extends StatefulWidget {
  const ItemsList({super.key});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  List<GroceryItem> _groceryItems = [];
  var isLoaded = false;
  var _error = false;
  final url = Uri.https(
      'shopping-list-backend-42d41-default-rtdb.firebaseio.com',
      'shopping-list.json');

  @override
  void initState() {
    super.initState();
    _updateItems();
  }

  void _updateItems() async {
    try {
      final response = await http.get(url);

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          context.mounted) {
        Map<String, dynamic>? dataMap = json.decode(response.body);
        final List<GroceryItem> loadedItems = [];
        if (dataMap != null) {
          for (final item in dataMap.entries) {
            final category = categories.entries
                .firstWhere(
                  (categoryItem) =>
                      categoryItem.value.name == item.value['category'],
                )
                .value;
            loadedItems.add(
              GroceryItem(
                  id: item.key,
                  name: item.value['name'],
                  quantity: item.value['quantity'],
                  category: category),
            );
          }
        }
        setState(() {
          _groceryItems = loadedItems;
          isLoaded = true;
        });
      } else if (response.statusCode >= 400) {
        setState(() {
          _error = true;
        });
      }
    } catch (error) {
      setState(() {
        _error = true;
      });
    }
  }

  void _addItem() async {
    final addedItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    setState(() {
      if (addedItem != null) {
        _groceryItems.add(addedItem);
      }
    });
  }

  void _removeItem(GroceryItem item, int index) async {
    setState(() {
      _groceryItems.remove(item);
    });

    Uri urlDelete = Uri.https(
        'shopping-list-backend-42d41-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final response = await http.delete(urlDelete);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _error
        ? const Center(
            child: Text(
              'Something went wrong! Try again later.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : (isLoaded
            ? (_groceryItems.isEmpty
                ? const Center(
                    child: Text(
                      'No items added',
                      style: TextStyle(fontSize: 35),
                    ),
                  )
                : ListView.builder(
                    itemCount: _groceryItems.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: ValueKey(_groceryItems[index].id),
                      onDismissed: (direction) {
                        _removeItem(_groceryItems[index], index);
                      },
                      child: GroceryItemWidget(_groceryItems[index]),
                    ),
                  ))
            : const Center(
                child: CircularProgressIndicator(),
              ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
