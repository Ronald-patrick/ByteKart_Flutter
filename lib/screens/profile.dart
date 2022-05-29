import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/providers/auth.dart';
import 'manage_products.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "My Orders",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            leading: Icon(
              Icons.payment,
              color: Colors.white,
            ),
            tileColor: Colors.teal,
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => OrdersScreen()));
            },
          ),
          ListTile(
            title: Text(
              "Manage Product",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            leading: Icon(
              Icons.add,
              color: Colors.white,
            ),
            tileColor: Colors.teal,
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ManageProducts()));
            },
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            tileColor: Colors.teal,
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
