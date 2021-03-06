import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> toogleFavorite() async {
    final oldFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url =
        'https://testshopapp-7b1e9-default-rtdb.firebaseio.com/products/$id.json';

    try {
      final resp = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (resp.statusCode >= 400) {
        isFavorite = oldFavorite;
      }
    } catch (e) {
       isFavorite = oldFavorite;
      print(e.toString());
    }
    notifyListeners();
  }
}
