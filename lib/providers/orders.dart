import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cartProvider.dart';
import 'cartProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> orders = [];

  final String authToken;

  Orders(this.authToken,this.orders);

  List<OrderItem> get orderList {
    return [...orders];
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        'https://bytekart-85549-default-rtdb.firebaseio.com/orders.json?auth=$authToken');
    try {
      final data = await http.get(url);
      final mapData = jsonDecode(data.body) as Map<String, dynamic>;
      if (mapData != null) {
        orders.clear();
        mapData.forEach((id, value) {
          orders.add(OrderItem(
              id: id,
              amount: value['amount'],
              products: (value['products'] as List<dynamic>)
                  .map((v) => CartItem(
                      id: v['id'],
                      title: v['title'],
                      quantity: v['quantity'],
                      price: v['price'],
                      size: v['size'],
                      img: v['img']))
                  .toList(),
              dateTime: DateTime.parse(value['date'])));
        });
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://bytekart-85549-default-rtdb.firebaseio.com/orders.json?auth=$authToken');
    var currTime = DateTime.now();
    try {
      final res = await http.post(url,
          body: jsonEncode({
            "amount": total,
            "date": currTime.toIso8601String(),
            "products": cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                      'size': cp.size,
                      'img': cp.img
                    })
                .toList()
          }));
    } catch (error) {
      print(error);
      throw error;
    }

    notifyListeners();
  }
}
