import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic data list to keep it simple for beginners
    final List<Map<String, dynamic>> cartItems = [
      {'name': 'Fresh Milk', 'price': 15.0, 'quantity': 2, 'image': Icons.local_drink},
      {'name': 'White Bread', 'price': 5.0, 'quantity': 1, 'image': Icons.bakery_dining},
      {'name': 'Red Apples', 'price': 25.0, 'quantity': 3, 'image': Icons.apple},
    ];

    // Simple calculation for the total
    double total = 0;
    for (var item in cartItems) {
      total += (item['price'] * item['quantity']);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping Cart'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Expanded list view to show items
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      child: Icon(item['image'] as IconData, color: const Color(0xFF1A73E8)),
                    ),
                    title: Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Price: \$${item['price']} x ${item['quantity']}'),
                    trailing: Text(
                      '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Bottom section for the total and button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Simple alert dialog for beginner-level interaction
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Order'),
                          content: const Text('Do you want to proceed to checkout?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Yes')),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A73E8),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
