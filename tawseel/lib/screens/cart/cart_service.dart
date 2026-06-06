// CartService manages everything about the shopping cart.
// It uses the Singleton pattern — one instance shared across the whole app.
// It extends ChangeNotifier so widgets can listen and rebuild when the cart changes.

import 'package:flutter/material.dart';
import 'cart_item.dart';

class CartService extends ChangeNotifier {
  // Singleton setup: this private constructor + static instance
  // means CartService.instance always gives you the SAME object
  static final CartService instance = CartService._internal();
  CartService._internal();

  // Private list — only CartService can directly modify this
  final List<CartItem> _items = [];

  // Public getter — gives a copy of the list so nothing can modify it from outside
  List<CartItem> get items => List.unmodifiable(_items);

  // Total number of individual products in the cart (sum of all quantities)
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  // Total price of everything in the cart
  double get total => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  // Add an item to the cart.
  // If the item already exists (same id), just increase its quantity by 1.
  // If it's new, add it to the list.
  void addItem(CartItem newItem) {
    final existingIndex = _items.indexWhere((item) => item.id == newItem.id);
    if (existingIndex >= 0) {
      // Item is already in cart — increment its quantity
      _items[existingIndex].quantity += 1;
    } else {
      // Brand new item — add it with quantity 1
      _items.add(newItem);
    }
    // Tell all listening widgets to rebuild
    notifyListeners();
  }

  // Remove an item completely from the cart using its id
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  // Increase the quantity of a specific item by 1
  void increaseQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _items[index].quantity += 1;
      notifyListeners();
    }
  }

  // Decrease the quantity of a specific item by 1.
  // If quantity would reach 0, remove the item entirely.
  void decreaseQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        // Quantity is 1, removing it would make 0 — just delete the item
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Empty the entire cart — called after an order is placed
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
