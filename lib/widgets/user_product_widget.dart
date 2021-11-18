
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product.dart';
import '../providers/products.dart';

class UserProductWidget extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  UserProductWidget(this.id , this.title,this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imgUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditProductScreen.route_name,arguments:id);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    Provider.of<Products>(context,listen: false).deleteProduct(id);
                  },
                ),
              ],
            ),
          ),
          title: Text(title),
       
    );
  }
}
