import 'package:flutter/cupertino.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1', title: "Sweatshirt", description: "Grey Men's SweatShirt", price: 550, imgurl: 'https://5.imimg.com/data5/FP/WR/FP/SELLER-67876/men-sweatshirt-500x500.jpg'),
      Product(
      id: 'p2', title: "Plain Hoodie", description: "Maroon Men's SweatShirt", price: 650, imgurl: 'https://5.imimg.com/data5/MM/RN/MY-7875833/5-500x500.jpg'),
      Product(
      id: 'p3', title: "Plain Hoodie", description: "Maroon Men's SweatShirt", price: 650, imgurl: 'https://5.imimg.com/data5/MM/RN/MY-7875833/5-500x500.jpg'),
      Product(
      id: 'p4', title: "Plain Hoodie", description: "Maroon Men's SweatShirt", price: 650, imgurl: 'https://5.imimg.com/data5/MM/RN/MY-7875833/5-500x500.jpg')
  ];

  List<Product> get items {
    return [..._items]; // Return Copy of items
  }

  void addProduct(value) {
    _items.add(value);
    notifyListeners();
  }
}
