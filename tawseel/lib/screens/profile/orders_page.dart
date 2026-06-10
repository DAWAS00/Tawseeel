// OrdersPage shows all the orders the user has placed.
// It loads orders from Supabase when the page opens.

import 'package:flutter/material.dart';
import '../cart/order_service.dart';
import '../cart/placed_order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    // Load orders from Supabase as soon as this page opens
    OrderService.instance.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
        title: const Text('My Orders',
            style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        elevation: 0,
      ),
      // ListenableBuilder rebuilds whenever OrderService calls notifyListeners()
      body: ListenableBuilder(
        listenable: OrderService.instance,
        builder: (context, child) {
          // Show a spinner while orders are being fetched from Supabase
          if (OrderService.instance.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF1A73E8)),
            );
          }

          final orders = OrderService.instance.orders;

          if (orders.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Dismissible(
                key: Key(order.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete_outline, color: Colors.white, size: 26),
                ),
                onDismissed: (_) async {
                  final error = await OrderService.instance.deleteOrder(order.id);
                  if (error != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not delete: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: _buildOrderCard(order),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(PlacedOrder order) {
    final date = order.placedAt.toLocal();
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final formattedDate =
        '${months[date.month - 1]} ${date.day} — ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    // Pick badge color based on status
    Color statusColor;
    Color statusBg;
    switch (order.status) {
      case 'delivered':
        statusColor = Colors.green.shade700;
        statusBg = Colors.green.shade50;
        break;
      case 'cancelled':
        statusColor = Colors.red.shade700;
        statusBg = Colors.red.shade50;
        break;
      default: // pending
        statusColor = Colors.orange.shade700;
        statusBg = Colors.orange.shade50;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.receipt_long,
                    color: Color(0xFF1A73E8), size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order.id.substring(order.id.length - 5)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      formattedDate,
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
              Text(
                '${order.total.toStringAsFixed(2)} JD',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A73E8),
                ),
              ),
            ],
          ),

          const Divider(height: 20),

          ...order.itemLines.map(
            (line) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.fiber_manual_record,
                      size: 8, color: Color(0xFF1A73E8)),
                  const SizedBox(width: 8),
                  Text(line,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF444444))),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withOpacity(0.4)),
                ),
                child: Text(
                  order.status[0].toUpperCase() + order.status.substring(1),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),

              const Spacer(),

              // Cancel button — only shown for pending orders
              if (order.status == 'pending')
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    final error = await OrderService.instance.cancelOrder(order.id);
                    if (error != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Could not cancel: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Cancel Order'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 64, color: Color(0xFFD0D0D0)),
          SizedBox(height: 12),
          Text(
            'No orders yet',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF888888)),
          ),
          SizedBox(height: 8),
          Text(
            'Place an order from the Vendors tab!',
            style: TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
          ),
        ],
      ),
    );
  }
}
