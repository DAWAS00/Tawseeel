// HomeBottomNav is the navigation bar at the bottom of the main shell.
// It shows 4 tabs: Home, Cart, Vendors, Profile.
// The Cart tab shows a red badge with the number of items when the cart is not empty.

import 'package:flutter/material.dart';
import '../../cart/cart_service.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder rebuilds the nav bar whenever the cart count changes
    return ListenableBuilder(
      listenable: CartService.instance,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_rounded, 'Home', 0),
                  _buildCartNavItem(), // Cart tab gets special treatment for the badge
                  _buildNavItem(Icons.store_outlined, 'Vendors', 2),
                  _buildNavItem(Icons.person_outline, 'Profile', 3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Build a regular nav item (no badge)
  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? const Color(0xFF1A73E8)
                : Colors.grey.shade400,
            size: 24,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? const Color(0xFF1A73E8)
                  : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  // Build the Cart nav item with a red badge showing how many items are in the cart.
  // The badge only appears when itemCount > 0.
  Widget _buildCartNavItem() {
    final bool isSelected = currentIndex == 1;
    final int itemCount = CartService.instance.itemCount;

    return GestureDetector(
      onTap: () => onTap(1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: isSelected
                    ? const Color(0xFF1A73E8)
                    : Colors.grey.shade400,
                size: 24,
              ),
              // Show the red badge only when there are items in the cart
              if (itemCount > 0)
                Positioned(
                  top: -6,
                  right: -8,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      itemCount > 99 ? '99+' : '$itemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            'Cart',
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? const Color(0xFF1A73E8)
                  : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
