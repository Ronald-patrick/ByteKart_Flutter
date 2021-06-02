import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_card.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    final productsData = Provider.of<Products>(context);
    final prod = productsData.items;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("ByteKart",style: TextStyle(fontSize: 24),),
        centerTitle: true,
       actions: [
         Icon(Icons.shopping_cart)
       ],
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey),
          BottomNavyBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favourites'),
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey),
          BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              title: Text('Cart'),
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey)
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: prod.length,
        itemBuilder: (context, index) => ProductCard(prod[index]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1,
            crossAxisSpacing: 30,
            mainAxisSpacing: 10),
      ),
    );
  }
}
