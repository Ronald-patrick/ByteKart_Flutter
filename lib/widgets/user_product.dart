import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/edit_product.dart';

class UserProduct extends StatelessWidget {
  final Product product;
  final Function deleteHandler;

  UserProduct(this.product, this.deleteHandler);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        tileColor: Colors.white,
        title: Text(product.title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imgurl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => EditProducts(product)));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {
                    deleteHandler(product.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Product Deleted !",style: TextStyle(fontSize: 20),),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.teal,
          ));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
