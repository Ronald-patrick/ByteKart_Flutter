import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart' as o;

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var loading = false;

  var _isinit = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      {
        setState(() {
          loading = true;
        });

        Provider.of<Orders>(context, listen: false).fetchOrders().then((value) {
          setState(() {
            loading = false;
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<OrderItem> orders =
        Provider.of<Orders>(context, listen: false).orderList;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Your Orders"),
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, index) {
                return o.OrderItem(orders[index]);
              }),
    );
  }
}
