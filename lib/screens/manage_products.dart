import 'package:flutter/material.dart';
import 'package:shop_app/screens/add_products.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/user_product.dart';
import '../providers/products_provider.dart';

class ManageProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final prod = productsData.items;

    void deletehandler(String id) {
      productsData.deleteProducts(id);
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Your Products'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => AddProducts()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: prod.length,
            itemBuilder: (ctx, i) => Column(
              children: [UserProduct(prod[i],deletehandler), Divider()],
            ),
          ),
        ));
  }
}
