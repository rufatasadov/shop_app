import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

class ProductOwerviewScreen extends StatefulWidget {
  @override
  _ProductOwerviewScreenState createState() => _ProductOwerviewScreenState();
}

class _ProductOwerviewScreenState extends State<ProductOwerviewScreen> {
  var _showOnlyFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterValueType val) {
              setState(() {
                if (val == FilterValueType.All) {
                  _showOnlyFav = false;
                } else {
                  _showOnlyFav = true;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterValueType.All,
              ),
              PopupMenuItem(
                child: Text('Show Favorite'),
                value: FilterValueType.OnlyFavorite,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: ch,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
        title: Text('Shop App'),
      ),
      body: ProductsGrid(_showOnlyFav),
    );
  }
}
