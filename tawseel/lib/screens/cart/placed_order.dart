// PlacedOrder represents a completed order saved in Supabase.

class PlacedOrder {
  final String id;
  final List<String> itemLines;
  final double total;
  final String status;
  final DateTime placedAt;

  PlacedOrder({
    required this.id,
    required this.itemLines,
    required this.total,
    required this.status,
    required this.placedAt,
  });

  // Create a PlacedOrder from a Supabase row (a Map of column → value)
  factory PlacedOrder.fromMap(Map<String, dynamic> map) {
    return PlacedOrder(
      id: map['id'] as String,
      // Supabase returns text[] as a List — cast each element to String
      itemLines: List<String>.from(map['items'] as List),
      total: (map['total'] as num).toDouble(),
      status: map['status'] as String? ?? 'pending',
      placedAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
