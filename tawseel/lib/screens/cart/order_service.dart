// OrderService stores all the orders the user has placed.
// It also uses the Singleton pattern so the order list persists
// across all screens during the app session.

import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'placed_order.dart';

class OrderService extends ChangeNotifier {
  // Singleton — one shared instance for the whole app
  static final OrderService instance = OrderService._internal();
  OrderService._internal();

  // Private list of all placed orders
  final List<PlacedOrder> _orders = [];

  // Public read-only access to the orders list
  List<PlacedOrder> get orders => List.unmodifiable(_orders);

  // Place a new order from the current cart items.
  // This converts cart items into a PlacedOrder and saves it.
  void placeOrder(List<CartItem> cartItems, double total) {
    // Build a human-readable line for each item, e.g. "Cheeseburger x2"
    final itemLines = cartItems
        .map((item) => '${item.name} x${item.quantity}')
        .toList();

    final order = PlacedOrder(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple unique ID
      itemLines: itemLines,
      total: total,
      placedAt: DateTime.now(),
    );

    // Insert at the front so the newest order appears at the top
    _orders.insert(0, order);

    // Tell all listening widgets to rebuild
    notifyListeners();
  }
}
