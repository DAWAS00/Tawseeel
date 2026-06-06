// This file defines what a single cart item looks like.
// Think of it like a row in a shopping list.

class CartItem {
  final String id;        // Unique ID to identify this item
  final String name;      // Name of the product (e.g. "Cheeseburger")
  final double price;     // Price per unit
  final String vendorName; // Which vendor/restaurant this item is from
  int quantity;           // How many the user wants (can change)

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.vendorName,
    this.quantity = 1,    // Default to 1 when first added
  });

  // Calculate the total cost for this line item (price × quantity)
  double get subtotal => price * quantity;
}
