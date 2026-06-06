// PlacedOrder represents a completed order that the user submitted.
// Once an order is placed, it is saved here so it shows up in "My Orders".

class PlacedOrder {
  final String id;              // Unique order ID (we use a timestamp)
  final List<String> itemLines; // Each item as a readable string, e.g. "Burger x2"
  final double total;           // Total amount paid
  final DateTime placedAt;      // When the order was placed

  PlacedOrder({
    required this.id,
    required this.itemLines,
    required this.total,
    required this.placedAt,
  });
}
