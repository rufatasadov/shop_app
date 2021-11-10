import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

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
                  ])
        ],
        title: Text('Shop App'),
      ),
      body: ProductsGrid(_showOnlyFav),
    );
  }
}
