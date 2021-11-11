import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final double price;
  final double quantity;
  final String title;

  CartItemWidget(this.id, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Text('\$${price}'),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${(quantity * price)}'),
          trailing: Text('${quantity}'),
        ),
      ),
    );
  }
}
