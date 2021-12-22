import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String img;
  final String size;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price,
      @required this.img,
      @required this.size});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int count() {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;

    _items.forEach((key, value) {
      total = total + value.quantity * value.price;
    });

    return total;
  }

  void deleteItem(String id) {
    print(id);
    _items.remove(id);
    print(_items);
    notifyListeners();
  }

  void addItem(String id, double price, String title, String img, String size) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price,
              img: value.img,
              size: value.size));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: id,
              title: title,
              quantity: 1,
              price: price,
              img: img,
              size: size));
    }
    notifyListeners();
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }

  void removeSingleItem(String prodId) {
    if (!_items.containsKey(prodId)) {
      return;
    }
    if (_items[prodId].quantity > 1) {
      _items.update(
          prodId,
          (cartItem) => CartItem(
              id: cartItem.id,
              title: cartItem.title,
              quantity: cartItem.quantity - 1,
              price: cartItem.price,
              img: cartItem.img,
              size: cartItem.size));
    } else {
      _items.remove(prodId);
    }
    notifyListeners();
  }
}
