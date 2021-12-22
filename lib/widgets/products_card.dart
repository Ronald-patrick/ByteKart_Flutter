import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/product_details.dart';

class ProductCard extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Product>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ProductDetails(productsData.id)));
          },
          child: Image.network(
            productsData.imgurl,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            productsData.title,
          ),
          backgroundColor: Color.fromRGBO(11, 20, 35, 0.7),
          leading: IconButton(
            icon: productsData.isfav
                ? Icon(
                    Icons.favorite,
                    size: 34,
                  )
                : Icon(
                    Icons.favorite_border,
                    size: 34,
                  ),
            color: Colors.red,
            onPressed: () {
              setState(() {
                productsData.toggleFavourite(productsData.id,authData.token,authData.userId);
              });
            },
          ),
          trailing: Text(
            "₹" + productsData.price.toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
