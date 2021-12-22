import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'dart:math';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  @override
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('₹${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
          if(_expanded) Container(padding: EdgeInsets.all(10),height: min(widget.order.products.length * 20.0 + 20,180) ,
          child: ListView(
            children: widget.order.products.map((prod) => Row(
              children: [
                Text(prod.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Spacer(),
                Text('${prod.quantity}  x  ₹${prod.price}',style: TextStyle(fontSize: 18,color: Colors.grey))
              ],
            )).toList(),
          ),)
        ],
      ),
    );
  }
}
