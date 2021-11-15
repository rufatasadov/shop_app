
import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product.dart';

class UserProductWidget extends StatelessWidget {

  final String title;
  final String imgUrl;

  UserProductWidget(this.title,this.imgUrl);

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
                    Navigator.of(context).pushNamed(EditProductScreen.route_name);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          title: Text(title),
       
    );
  }
}
