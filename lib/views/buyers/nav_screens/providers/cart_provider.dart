import 'package:flutter/material.dart';
import 'package:island_goods/views/buyers/nav_screens/widgets/item_list_widget.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem cartItem) {
    _cartItems.add(cartItem);
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
