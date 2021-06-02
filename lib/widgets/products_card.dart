import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/product_details.dart';

class ProductCard extends StatefulWidget {
  final Product item;

  ProductCard(this.item);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isfav = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
            MaterialPageRoute
            (   
              builder: (ctx) => ProductDetails(widget.item)
            ));
          },
          child: Image.network(
            widget.item.imgurl,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            widget.item.title,
          ),
          backgroundColor: Color.fromRGBO(11, 20, 35, 0.7),
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              size: 34,
            ),
            color: isfav ? Colors.red : Colors.white,
            onPressed: () {
              setState(() {
                isfav = !isfav;
              });
            },
          ),
          trailing: Text(
            "₹" + widget.item.price.toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
