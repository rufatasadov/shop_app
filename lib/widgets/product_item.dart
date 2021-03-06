import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    print('rebuild widget');
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
            fit: BoxFit.fill,
          ),
        ),
        header: Container(
          height: 25,
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
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toogleFavorite();
 
 
              },
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
               ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Add item to cart.'),
                  duration: Duration(milliseconds: 1500),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
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
