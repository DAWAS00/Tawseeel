// This file holds the mock menu items for each vendor.
// In a real app, these would be fetched from a database (Supabase).
// For now we define them here as static data so the UI can work.

import 'package:flutter/material.dart';

// MenuItem represents a single product that a vendor sells
class MenuItem {
  final String id;          // Unique item ID
  final String name;        // Product name, e.g. "Classic Cheeseburger"
  final String description; // Short description shown under the name
  final double price;       // Price in JD
  final IconData icon;      // Icon shown as a placeholder for the product image

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

// A map from vendor name → list of MenuItems for that vendor
final Map<String, List<MenuItem>> vendorMenus = {
  'Gourmet Burger Kitchen': [
    MenuItem(
      id: 'gbk_1',
      name: 'Classic Cheeseburger',
      description: 'Beef patty, cheddar, lettuce, tomato, pickles',
      price: 4.5,
      icon: Icons.lunch_dining,
    ),
    MenuItem(
      id: 'gbk_2',
      name: 'Double Smash Burger',
      description: 'Two smashed patties, special sauce, caramelized onions',
      price: 6.5,
      icon: Icons.lunch_dining,
    ),
    MenuItem(
      id: 'gbk_3',
      name: 'Crispy Chicken Burger',
      description: 'Fried chicken breast, coleslaw, mayo',
      price: 5.0,
      icon: Icons.set_meal,
    ),
    MenuItem(
      id: 'gbk_4',
      name: 'Loaded Fries',
      description: 'Fries topped with cheese sauce and jalapeños',
      price: 2.5,
      icon: Icons.fastfood,
    ),
    MenuItem(
      id: 'gbk_5',
      name: 'Milkshake',
      description: 'Chocolate, vanilla, or strawberry',
      price: 2.0,
      icon: Icons.local_drink,
    ),
  ],
  'The Artisan Bakery': [
    MenuItem(
      id: 'tab_1',
      name: 'Sourdough Loaf',
      description: 'Classic slow-fermented sourdough, crispy crust',
      price: 3.0,
      icon: Icons.bakery_dining,
    ),
    MenuItem(
      id: 'tab_2',
      name: 'Butter Croissant',
      description: 'Flaky, buttery, baked fresh each morning',
      price: 1.2,
      icon: Icons.breakfast_dining,
    ),
    MenuItem(
      id: 'tab_3',
      name: 'Cinnamon Roll',
      description: 'Soft dough, cinnamon sugar, cream cheese glaze',
      price: 1.5,
      icon: Icons.donut_small,
    ),
    MenuItem(
      id: 'tab_4',
      name: 'Blueberry Muffin',
      description: 'Made with fresh blueberries and lemon zest',
      price: 1.0,
      icon: Icons.cake,
    ),
    MenuItem(
      id: 'tab_5',
      name: 'Avocado Toast',
      description: 'Sourdough, smashed avocado, poached egg, chili flakes',
      price: 3.5,
      icon: Icons.eco,
    ),
  ],
  'Fresh Mart Hyper': [
    MenuItem(
      id: 'fmh_1',
      name: 'Organic Milk (1L)',
      description: 'Fresh full-fat organic milk',
      price: 1.8,
      icon: Icons.local_drink,
    ),
    MenuItem(
      id: 'fmh_2',
      name: 'Eggs (12 pack)',
      description: 'Free-range large eggs',
      price: 2.2,
      icon: Icons.egg,
    ),
    MenuItem(
      id: 'fmh_3',
      name: 'Red Apples (1kg)',
      description: 'Fresh seasonal red apples',
      price: 1.5,
      icon: Icons.apple,
    ),
    MenuItem(
      id: 'fmh_4',
      name: 'Whole Wheat Bread',
      description: 'Sliced whole wheat loaf',
      price: 1.0,
      icon: Icons.bakery_dining,
    ),
    MenuItem(
      id: 'fmh_5',
      name: 'Cheddar Cheese (200g)',
      description: 'Aged cheddar block',
      price: 2.5,
      icon: Icons.restaurant,
    ),
    MenuItem(
      id: 'fmh_6',
      name: 'Orange Juice (1L)',
      description: 'Freshly squeezed, no added sugar',
      price: 2.0,
      icon: Icons.local_bar,
    ),
  ],
  'Sushi Palace': [
    MenuItem(
      id: 'sp_1',
      name: 'Salmon Nigiri (2 pcs)',
      description: 'Fresh salmon over hand-pressed sushi rice',
      price: 3.5,
      icon: Icons.set_meal,
    ),
    MenuItem(
      id: 'sp_2',
      name: 'Dragon Roll (8 pcs)',
      description: 'Shrimp tempura inside, avocado & eel on top',
      price: 7.0,
      icon: Icons.rice_bowl,
    ),
    MenuItem(
      id: 'sp_3',
      name: 'Tuna Sashimi (5 pcs)',
      description: 'Premium bluefin tuna, sliced fresh',
      price: 6.0,
      icon: Icons.set_meal,
    ),
    MenuItem(
      id: 'sp_4',
      name: 'Edamame',
      description: 'Steamed salted soybeans',
      price: 1.5,
      icon: Icons.eco,
    ),
    MenuItem(
      id: 'sp_5',
      name: 'Miso Soup',
      description: 'Classic miso broth with tofu and wakame',
      price: 1.0,
      icon: Icons.soup_kitchen,
    ),
    MenuItem(
      id: 'sp_6',
      name: 'Matcha Ice Cream',
      description: 'Green tea flavored soft-serve',
      price: 2.0,
      icon: Icons.icecream,
    ),
  ],
};

// Helper: get menu items for a vendor name.
// Returns an empty list if the vendor has no menu defined yet.
List<MenuItem> getMenuForVendor(String vendorName) {
  return vendorMenus[vendorName] ?? [];
}
