import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: Container(
          height: 30,
          child: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(
              '\$${product.price.toString()}',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold),
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          trailing: IconButton(
            onPressed: () {},
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
