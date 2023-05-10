import 'package:flutter/material.dart';
import 'cart_item.dart';
class Cart extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(CartItem newItem) {
    // Check if the new item is already in the cart
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].name == newItem.name) {
        _items[i].quantity += newItem.quantity;
        notifyListeners();
        return;
      }
    }
    // If not, add the new item to the cart
    _items.add(newItem);
    notifyListeners();
  }

  void removeItem(CartItem item) {
  if (item.quantity == 1) {
      _items.remove(item);
  } else {
    item.quantity--;
  }
  notifyListeners();
}


  double getTotal() {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
  void clearCart() {
  _items.clear();
  notifyListeners();
}

  List<CartItem> get basketItems {
    return items;
  }
}