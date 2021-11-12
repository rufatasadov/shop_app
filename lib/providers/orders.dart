import 'package:flutter/material.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> prodcuts;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.prodcuts,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _Items = [];
  List<OrderItem> get items {
    return [..._Items];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _Items.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        prodcuts: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clear() {
    _Items.clear();
    print('cleared Ordes');
    notifyListeners();
  }
}
