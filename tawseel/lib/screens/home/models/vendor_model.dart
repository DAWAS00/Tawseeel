import 'package:flutter/material.dart';

class Vendor {
  final String name;
  final String imageUrl;
  final String? category;
  final Color? categoryColor;
  final String? type;
  final String? distance;

  Vendor({
    required this.name,
    required this.imageUrl,
    this.category,
    this.categoryColor,
    this.type,
    this.distance,
  });

  // Factory to create from Map if needed, but we'll use constructors for now
}
