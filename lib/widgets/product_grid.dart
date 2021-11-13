import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

enum FilterValueType { All, OnlyFavorite }

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFav;
  ProductsGrid(this.showOnlyFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productList =
        showOnlyFav ? productsData.OnlyFavorites : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productList.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: productList[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
