// VendorDetailPage shows the menu of a specific vendor.
// The user can add items to their cart from this page.
// Tapping the "View Cart" bar at the bottom navigates to the cart screen.

import 'package:flutter/material.dart';
import '../cart/cart_item.dart';
import '../cart/cart_service.dart';
import 'vendor_menu_data.dart';

class VendorDetailPage extends StatefulWidget {
  // All vendor info is passed in from the vendor list screen
  final String vendorName;
  final String category;
  final String imageUrl;
  final double rating;
  final String deliveryTime;

  const VendorDetailPage({
    super.key,
    required this.vendorName,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
  });

  @override
  State<VendorDetailPage> createState() => _VendorDetailPageState();
}

class _VendorDetailPageState extends State<VendorDetailPage> {
  // We need CartService to add items when the user taps "Add"
  final CartService _cartService = CartService.instance;

  @override
  Widget build(BuildContext context) {
    // Get the menu items for this vendor from our mock data
    final menuItems = getMenuForVendor(widget.vendorName);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Top header image + back button + vendor info
          _buildHeader(context),

          // List of menu items the vendor sells
          Expanded(
            child: menuItems.isEmpty
                ? _buildEmptyMenu() // Show a message if no menu data
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return _buildMenuItemCard(menuItems[index]);
                    },
                  ),
          ),

          // Bottom bar that shows cart count and a "View Cart" button
          // It uses ListenableBuilder so it rebuilds whenever the cart changes
          ListenableBuilder(
            listenable: _cartService,
            builder: (context, child) {
              // Only show the bottom bar if there is at least one item in the cart
              if (_cartService.itemCount == 0) return const SizedBox.shrink();
              return _buildCartBar(context);
            },
          ),
        ],
      ),
    );
  }

  // Build the top section: hero image + back button + vendor name/info
  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        // Vendor cover image
        Image.network(
          widget.imageUrl,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 220,
              color: Colors.grey.shade300,
              child: const Icon(Icons.store, size: 60, color: Colors.grey),
            );
          },
        ),

        // Dark overlay so the back button is visible on any image
        Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Back button in the top-left corner
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
                onPressed: () => Navigator.pop(context), // Go back to vendor list
              ),
            ),
          ),
        ),

        // Vendor name, category, rating at the bottom of the image area
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.vendorName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      widget.category,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.star,
                        color: Color(0xFFFFC107), size: 14),
                    const SizedBox(width: 3),
                    Text(
                      widget.rating.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 13),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.access_time,
                        color: Colors.white70, size: 14),
                    const SizedBox(width: 3),
                    Text(
                      widget.deliveryTime,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Build a single menu item card with an Add button
  Widget _buildMenuItemCard(MenuItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Item icon (placeholder for product image)
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon,
                  size: 32, color: const Color(0xFF1A73E8)),
            ),

            const SizedBox(width: 12),

            // Item name, description, and price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.description,
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${item.price.toStringAsFixed(2)} JD',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A73E8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Add to Cart button — calls addItem on CartService
            _buildAddButton(item),
          ],
        ),
      ),
    );
  }

  // The "+ Add" button that adds this item to the cart.
  // Uses ListenableBuilder so the button label updates if the item is already in cart.
  Widget _buildAddButton(MenuItem item) {
    return ListenableBuilder(
      listenable: _cartService,
      builder: (context, child) {
        // Check if this item is already in the cart
        final inCart = _cartService.items.any((c) => c.id == item.id);

        return GestureDetector(
          onTap: () {
            // Add this menu item to the cart when the user taps the button
            _cartService.addItem(
              CartItem(
                id: item.id,
                name: item.name,
                price: item.price,
                vendorName: widget.vendorName,
              ),
            );

            // Show a quick confirmation message at the bottom of the screen
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${item.name} added to cart'),
                duration: const Duration(milliseconds: 1200),
                backgroundColor: const Color(0xFF1A73E8),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 80),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: inCart
                  ? const Color(0xFF1A73E8) // Blue when already added
                  : const Color(0xFFE8F0FE), // Light blue when not added
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              inCart ? 'Add More' : '+ Add',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: inCart ? Colors.white : const Color(0xFF1A73E8),
              ),
            ),
          ),
        );
      },
    );
  }

  // The sticky bar at the bottom that shows cart summary and links to cart screen
  Widget _buildCartBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Navigate back to the main shell and switch to the Cart tab (index 1)
          Navigator.pop(context); // Close vendor detail page
          // The user will see the cart tab in the bottom nav
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A73E8),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Badge showing number of items
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_cartService.itemCount} items',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
            const Text(
              'View Cart',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            // Total price on the right
            Text(
              '${_cartService.total.toStringAsFixed(2)} JD',
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Shown when a vendor has no menu items defined yet
  Widget _buildEmptyMenu() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book_outlined, size: 60, color: Color(0xFFD0D0D0)),
          SizedBox(height: 12),
          Text(
            'Menu coming soon',
            style: TextStyle(fontSize: 15, color: Color(0xFFAAAAAA)),
          ),
        ],
      ),
    );
  }
}
