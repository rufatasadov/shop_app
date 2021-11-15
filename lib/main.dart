import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/edit_product.dart';
import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_owerview_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.deepOrange,
          primaryColor: Colors.purple,
          fontFamily: 'Lato',
        ),
        home: ProductOwerviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.route_name: (ctx) => OrdersScreen(),
          UserProductsScreen.route_name: (ctx) => UserProductsScreen(),
          EditProductScreen.route_name: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
