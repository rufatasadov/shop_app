import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './product.dart';
import '../models/http_exceptions.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    //   Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   ),
    //   Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   ),
    //   Product(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl:
    //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   ),
    //   Product(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ),
  ];

  Future<void> fetchProducts() async {
    const url =
        'https://testshopapp-7b1e9-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extactedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedList = [];
      extactedData.forEach((prodID, prodData) {
        loadedList.add(
          Product(
            id: prodID,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedList;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Product findByIndex(String id) {
    return _items.firstWhere((e) => e.id == id);
  }

  List<Product> get OnlyFavorites {
    return _items.where((e) => e.isFavorite == true).toList();
  }

  List<Product> get items {
    return [..._items];
  }

  Future<void> addProduct(Product item) async {
    const url =
        'https://testshopapp-7b1e9-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': item.title,
          'description': item.description,
          'imageUrl': item.imageUrl,
          'price': item.price,
          'isFavorite': item.isFavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: item.title,
        description: item.description,
        imageUrl: item.imageUrl,
        price: item.price,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      print('error :  ${e}');
      throw e;
    }
  }

  Future<void> updateProduct(Product item) async {
    final prodIndex = _items.indexWhere((element) => element.id == item.id);

    final url =
        'https://testshopapp-7b1e9-default-rtdb.firebaseio.com/products/${item.id}.json';
    try {
      await http.patch(url,
          body: json.encode({
            'title': item.title,
            'description': item.description,
            'imageUrl': item.imageUrl,
            'price': item.price,
            'isFavorite': item.isFavorite,
          }));

      _items[prodIndex] = item;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://testshopapp-7b1e9-default-rtdb.firebaseio.com/products/${id}.json';
    final deletedIndex = _items.indexWhere((element) => element.id == id);
    var deletedItem = _items[deletedIndex];

    _items.removeAt(deletedIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(deletedIndex, deletedItem);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    deletedItem = null;
  }
}
