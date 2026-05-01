import 'package:flutter/material.dart';
import 'models/vendor_model.dart';

class HomeController {
  int selectedCategory = 0;
  int selectedNavIndex = 0;

  final List<String> categories = [
    'All',
    'Food',
    'Electronics',
    'Clothes',
    'Services',
  ];

  final List<Vendor> nearYouVendors = [
    Vendor(
      name: 'Burger Station',
      category: 'FOOD',
      categoryColor: const Color(0xFFE65100),
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
    ),
    Vendor(
      name: 'Tech Haven',
      category: 'ELECTRONICS',
      categoryColor: const Color(0xFFF9A825),
      imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400&q=80',
    ),
  ];

  final List<Vendor> recentlyAdded = [
    Vendor(
      name: 'Paws & Claws',
      type: 'Services',
      distance: '1.2 km',
      imageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=200&q=80',
    ),
    Vendor(
      name: 'City Health Pharmacy',
      type: 'Pharmacy',
      distance: '2.5 km',
      imageUrl: 'https://images.unsplash.com/photo-1631549916768-4119b2e5f926?w=200&q=80',
    ),
    Vendor(
      name: 'Buildit Supplies',
      type: 'Hardware',
      distance: '3.1 km',
      imageUrl: 'https://images.unsplash.com/photo-1504148455328-c376907d081c?w=200&q=80',
    ),
  ];

  void goToVendor(BuildContext context, String vendorName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $vendorName...'),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF1A73E8),
      ),
    );
  }
  
  void dispose() {
    // Cleanup if needed
  }
}
