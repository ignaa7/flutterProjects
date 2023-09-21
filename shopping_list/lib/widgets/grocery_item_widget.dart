import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemWidget extends StatelessWidget {
  final GroceryItem item;

  const GroceryItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      leading: Container(
        width: 24,
        height: 24,
        color: item.category.color,
      ),
      trailing: Text(item.quantity.toString()),
    );
    /* Row(
        children: [
          Icon(
            Icons.square,
            color: item.category.color,
          ),
          const SizedBox(width: 25),
          Text(item.name),
          Expanded(
              child: Text(
            item.quantity.toString(),
            textAlign: TextAlign.end,
          )),
        ],
      ); */
  }
}
