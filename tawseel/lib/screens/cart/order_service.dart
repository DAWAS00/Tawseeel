import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cart_item.dart';
import 'placed_order.dart';

class OrderService extends ChangeNotifier {
  static final OrderService instance = OrderService._internal();
  OrderService._internal();

  final _supabase = Supabase.instance.client;

  List<PlacedOrder> _orders = [];
  List<PlacedOrder> get orders => List.unmodifiable(_orders);

  bool isLoading = false;

  // Returns null on success, or an error message string on failure.
  Future<String?> placeOrder(List<CartItem> cartItems, double total) async {
    try {
      // user_id is nullable for now (login is bypassed during testing)
      final userId = _supabase.auth.currentUser?.id;

      debugPrint('=== placeOrder called ===');
      debugPrint('userId: $userId');
      debugPrint('total: $total');
      debugPrint('items: ${cartItems.map((i) => i.name).toList()}');

      final itemLines = cartItems
          .map((item) => '${item.name} x${item.quantity}')
          .toList();

      debugPrint('Inserting into cart_orders...');

      await _supabase.from('cart_orders').insert({
        'user_id': userId,   // null is allowed while login is bypassed
        'items': itemLines,
        'total': total,
        'status': 'pending',
      });

      debugPrint('Insert SUCCESS — reloading orders...');
      await loadOrders();
      return null;
    } catch (e) {
      debugPrint('ERROR placing order: $e');
      return e.toString();
    }
  }

  // Changes order status to 'cancelled' in Supabase.
  // Returns null on success, or an error message on failure.
  Future<String?> cancelOrder(String orderId) async {
    try {
      await _supabase
          .from('cart_orders')
          .update({'status': 'cancelled'})
          .eq('id', orderId);
      await loadOrders();
      return null;
    } catch (e) {
      debugPrint('ERROR cancelling order: $e');
      return e.toString();
    }
  }

  // Deletes the order row from Supabase entirely.
  // Returns null on success, or an error message on failure.
  Future<String?> deleteOrder(String orderId) async {
    try {
      await _supabase
          .from('cart_orders')
          .delete()
          .eq('id', orderId);
      await loadOrders();
      return null;
    } catch (e) {
      debugPrint('ERROR deleting order: $e');
      return e.toString();
    }
  }

  Future<void> loadOrders() async {
    try {
      isLoading = true;
      notifyListeners();

      debugPrint('=== loadOrders called ===');

      // Load all orders (no user filter while login is bypassed)
      final rows = await _supabase
          .from('cart_orders')
          .select()
          .order('created_at', ascending: false);

      debugPrint('Loaded ${(rows as List).length} orders from Supabase');

      _orders = rows.map((row) => PlacedOrder.fromMap(row)).toList();
    } catch (e) {
      debugPrint('ERROR loading orders: $e');
      _orders = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
