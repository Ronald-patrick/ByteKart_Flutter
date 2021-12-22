import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgurl;
  bool isfav;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imgurl,
    this.isfav = false,
  });

  Future<void> toggleFavourite(String id, String token, String userId) async {
    final oldfav = isfav;
    final url = Uri.parse(
        'https://bytekart-85549-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token');

    try {
      isfav = !isfav;
      final res = await http.put(url, body: jsonEncode(isfav));
      notifyListeners();
      if (res.statusCode >= 400) {
        isfav = oldfav;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      isfav = oldfav;
      print(isfav);
      notifyListeners();
    }
  }
}
