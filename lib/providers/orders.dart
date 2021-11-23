import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _Items = [];
  List<OrderItem> get items {
    return [..._Items];
  }

  Future<void> fetchOrders() async {
    const url =
        'https://testshopapp-7b1e9-default-rtdb.firebaseio.com/orders.json';
    final resp = await http.get(url);
    final extactedData = json.decode(resp.body) as Map<String, dynamic>;

    List<OrderItem> loadedItems = [];

    if (extactedData == null) {
      return;
    }

    extactedData.forEach((orderId, orderData) {
      loadedItems.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime']),
        ),
      );
    });
    _Items = loadedItems.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url =
        'https://testshopapp-7b1e9-default-rtdb.firebaseio.com/orders.json';
    final dt = DateTime.now();
    try {
      final resp = await http.post(url,
          body: json.encode({
            'amount': total,
            'products': cartProducts
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price,
                    })
                .toList(),
            'dateTime': dt.toIso8601String(),
          }));

      if (resp.statusCode < 400) {
        _Items.insert(
          0,
          OrderItem(
            id: json.decode(resp.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: dt,
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      // ...
    }
  }

  void clear() {
    _Items.clear();
    print('cleared Ordes');
    notifyListeners();
  }
}
