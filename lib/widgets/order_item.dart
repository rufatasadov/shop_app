import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/orders.dart' as ord;

class OrderItemWidget extends StatefulWidget {
  final ord.OrderItem order;
  OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expanded = false;



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          _expanded
              ? Container(
                  padding: EdgeInsets.all(10),
                  height: min(widget.order.products.length * 25.0 + 20, 120),
                  child: ListView.builder(
                      itemCount: widget.order.products.length,
                      itemBuilder: (ctx, i) => Container(
                        height: 25,
                  
                        child: Row(
                              children: [
                                Text(
                                  widget.order.products[i].title,
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  '${widget.order.products[i].quantity}x \$${widget.order.products[i].price}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                      ),),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
