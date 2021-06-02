import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/models/product.dart';

class ProductDetails extends StatelessWidget {
  final Product item;
  ProductDetails(this.item);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       floatingActionButton: FloatingActionButton.extended(
         backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {},
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          icon: Icon(Icons.shopping_cart),
          label: Text('Add to Cart'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Ink(
            decoration: ShapeDecoration(
              color: Theme.of(context).primaryColor,
              shape: CircleBorder(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
            SizedBox(
              height: 7,
            ),
            Image.network(item.imgurl),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                  Text( "₹" +item.price.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Text(item.description,style: TextStyle(fontSize: 20,color: Colors.grey),)

          ],
        ),
      ),
    );
  }
}
