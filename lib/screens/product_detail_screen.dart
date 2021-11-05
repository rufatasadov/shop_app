import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final providerdata = Provider.of<Products>(context);
    final title = providerdata.items
        .firstWhere((element) => element.id == productId)
        .title;
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: null,
    );
  }
}
