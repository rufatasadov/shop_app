import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

class ProductOwerviewScreen extends StatefulWidget {
  @override
  _ProductOwerviewScreenState createState() => _ProductOwerviewScreenState();
}

class _ProductOwerviewScreenState extends State<ProductOwerviewScreen> {
  var _showOnlyFav = false;
  var _isFetched = false;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {

    if (!_isFetched) {

      try {
         setState(() {
            _isLoading = true;
          });
        Provider.of<Products>(context).fetchProducts().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
        _isFetched = true;
      } catch (e) {}
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
      body: _isLoading? Center(child: CircularProgressIndicator(),)  : ProductsGrid(_showOnlyFav),
    );
  }
}
