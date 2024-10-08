import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Product> _items = {};

  Map<String, Product> get items => {..._items};

  void addItem(Product product) {
    _items.putIfAbsent(product.id, () => product);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }
}
