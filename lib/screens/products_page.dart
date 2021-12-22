import 'package:flutter/material.dart';
import 'package:shop_app/screens/favourites.dart';
import 'package:shop_app/screens/profile.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'HomeScreen.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int currentIndex = 0;
  List<Widget> _widgets = <Widget>[HomeScreen(), Favourites(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedIndex: currentIndex,
          animationDuration: Duration(milliseconds: 500),
          onItemSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.teal,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favourites'),
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                activeColor: Colors.teal,
                inactiveColor: Colors.grey)
          ],
        ),
        body: _widgets.elementAt(currentIndex));
  }
}
