import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/products_card.dart';
import 'cart_screen.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<Products>(context, listen: false).favItems;
        print("object");
    return Scaffold(

      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "ByteKart",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => CartScreen()));
              },
              icon: Icon(
                Icons.shopping_cart,
                size: 26,
              )),
        ],
      ),
      body: productsData.isEmpty
          ? Center(
              child: Text(
                "No Favourites!",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: productsData.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: productsData[index], child: ProductCard()),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
            ),
    );
  }
}
