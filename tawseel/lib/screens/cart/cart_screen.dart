// CartScreen shows all the items the user has added to their cart.
// The user can increase/decrease quantity, remove items, or place the order.
// It listens to CartService so it rebuilds automatically when the cart changes.

import 'package:flutter/material.dart';
import 'cart_service.dart';
import 'order_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // ListenableBuilder rebuilds the whole screen whenever the cart changes
      body: ListenableBuilder(
        listenable: CartService.instance,
        builder: (context, child) {
          final cartItems = CartService.instance.items;

          // Show an empty state if the cart has no items
          if (cartItems.isEmpty) {
            return _buildEmptyCart();
          }

          // Cart has items — show the list + checkout section
          return Column(
            children: [
              // Scrollable list of cart items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return _buildCartItemCard(context, cartItems[index]);
                  },
                ),
              ),

              // Bottom section: total price + Place Order button
              _buildCheckoutSection(context),
            ],
          );
        },
      ),
    );
  }

  // Build a single cart item row with quantity controls and a remove button
  Widget _buildCartItemCard(BuildContext context, dynamic item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Item icon placeholder
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.fastfood,
                size: 28, color: Color(0xFF1A73E8)),
          ),

          const SizedBox(width: 12),

          // Item name, vendor, and price per unit
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.vendorName,
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.price.toStringAsFixed(2)} JD each',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A73E8),
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls: minus button, count, plus button
          Column(
            children: [
              Row(
                children: [
                  // Decrease quantity (or remove if at 1)
                  _buildQuantityButton(
                    icon: Icons.remove,
                    onTap: () {
                      CartService.instance.decreaseQuantity(item.id);
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),

                  // Increase quantity
                  _buildQuantityButton(
                    icon: Icons.add,
                    onTap: () {
                      CartService.instance.increaseQuantity(item.id);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Remove button — completely deletes this item from the cart
              GestureDetector(
                onTap: () {
                  CartService.instance.removeItem(item.id);
                },
                child: Text(
                  'Remove',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // A small circular button used for + and − quantity controls
  Widget _buildQuantityButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0FE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF1A73E8)),
      ),
    );
  }

  // Bottom section showing the total price and the Place Order button
  Widget _buildCheckoutSection(BuildContext context) {
    final total = CartService.instance.total;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Order total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                '${total.toStringAsFixed(2)} JD',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A73E8),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Place Order button — saves the order and clears the cart
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => _placeOrder(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A73E8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Called when the user taps "Place Order".
  // Shows a confirmation dialog first. If they confirm, save the order and clear the cart.
  void _placeOrder(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirm Order',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: Text(
          'Place order for ${CartService.instance.total.toStringAsFixed(2)} JD?',
        ),
        actions: [
          // Cancel — just closes the dialog without doing anything
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.grey)),
          ),

          // Confirm — save the order and clear the cart
          ElevatedButton(
            onPressed: () {
              // Save the current cart as a PlacedOrder in OrderService
              OrderService.instance.placeOrder(
                CartService.instance.items.toList(),
                CartService.instance.total,
              );

              // Empty the cart now that the order has been placed
              CartService.instance.clearCart();

              // Close the dialog
              Navigator.pop(dialogContext);

              // Show a success message to the user
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Order placed! Check My Orders in your profile.'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A73E8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  // Shown when the cart is empty
  Widget _buildEmptyCart() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 72, color: Color(0xFFD0D0D0)),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF888888)),
          ),
          SizedBox(height: 8),
          Text(
            'Go to Vendors and add some items!',
            style: TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
          ),
        ],
      ),
    );
  }
}
