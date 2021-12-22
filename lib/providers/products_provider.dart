import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://bytekart-85549-default-rtdb.firebaseio.com/products.json?auth=$authToken');

    print("Auth Token " + authToken);

    try {
      final data = await http.get(url);
      final mapData = jsonDecode(data.body) as Map<String, dynamic>;
      _items.clear();

      final url2 = Uri.parse(
          'https://bytekart-85549-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken');

      final favresponse = await http.get(url2);

      final favData = jsonDecode(favresponse.body);

      mapData.forEach((id, value) {
        _items.add(Product(
            id: id,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imgurl: value['imgUrl'],
            isfav: favData ==null ? false : favData[id] ?? false));
      });
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  final String authToken;
  final String userId;
  Products(this.authToken, this._items, this.userId);

  List<Product> get items {
    return [..._items]; // Return Copy of items
  }

  List<Product> get favItems {
    return _items.where((element) => element.isfav).toList();
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://bytekart-85549-default-rtdb.firebaseio.com/products.json?auth=$authToken');

    try {
      final response = await http.post(url,
          body: json.encode({
            "title": product.title,
            "imgUrl": product.imgurl,
            "description": product.description,
            "price": product.price,
          }));

      final id = json.decode(response.body)['name'];
      final newProduct = Product(
          id: id,
          title: product.title,
          description: product.description,
          price: product.price,
          imgurl: product.imgurl,
          isfav: false);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> updateProducts(Product product) async {
    final url = Uri.parse(
        'https://bytekart-85549-default-rtdb.firebaseio.com/products/${product.id}.json?auth=$authToken');

    try {
      final res = await http.patch(url,
          body: jsonEncode({
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imgUrl": product.imgurl
          }));
      final newProduct = Product(
          id: product.id,
          title: product.title,
          description: product.description,
          price: product.price,
          imgurl: product.imgurl);
      final index = _items.indexWhere((prod) => prod.id == product.id);
      _items[index] = newProduct;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void deleteProducts(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
