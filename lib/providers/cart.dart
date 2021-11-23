import 'package:flutter/foundation.dart';


class CartItem {
  String id;
  String title;
  double price;
  double quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);

    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (oldValue) => CartItem(
          id: oldValue.id,
          title: oldValue.title,
          price: oldValue.price,
          quantity: oldValue.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    print('cleared cart');
    notifyListeners();
  }

  Future<void> addItem(String productId, double price, String title)  async{

          

    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (oldItem) => CartItem(
            id: oldItem.id,
            title: oldItem.title,
            price: oldItem.price,
            quantity: oldItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
