import 'package:flutter/material.dart';

final List<Map<String, dynamic>> topVendors = [
  {
    'name': 'Leather Craft Co.',
    'description':
    'Handcrafted leather goods made with premium quality materials.',
    'rating': 4.8,
    'imageUrl':
    'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&q=80',
  },
  {
    'name': 'Golden Jewelry',
    'description':
    'Exclusive gold and silver jewelry crafted by expert artisans.',
    'rating': 4.9,
    'imageUrl':
    'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=400&q=80',
  },
  {
    'name': 'Sweet Tooth Bakery',
    'description': 'Freshly baked goods and pastries delivered to your door.',
    'rating': 4.6,
    'imageUrl':
    'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&q=80',
  },
  {
    'name': 'Om Ali Kitchen',
    'description':
    'Authentic home cooked meals prepared with fresh ingredients.',
    'rating': 4.7,
    'imageUrl':
    'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=400&q=80',
  },
];

class VendorRequestCard extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String imageUrl;
  final VoidCallback onRequest;

  const VendorRequestCard({
    super.key,
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.onRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: Image.network(
              imageUrl,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 110,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF1A73E8),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 110,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image,
                      color: Colors.grey, size: 30),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFC107), size: 13),
                    const SizedBox(width: 3),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A73E8),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Request Now',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class RequestingPage extends StatefulWidget {
  const RequestingPage({super.key});

  @override
  State<RequestingPage> createState() => _RequestingPageState();
}

class _RequestingPageState extends State<RequestingPage> {
  int _requestedIndex = -1;

  void _onRequest(int index) {
    setState(() {
      _requestedIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request sent to ${topVendors[index]['name']}!'),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF1A73E8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top Vendors',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'The best vendors selected based on your ratings and reviews.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(
                      (topVendors.length / 2).ceil(),
                          (rowIndex) {
                        final int firstIndex = rowIndex * 2;
                        final int secondIndex = firstIndex + 1;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: VendorRequestCard(
                                  name: topVendors[firstIndex]['name']
                                  as String,
                                  description: topVendors[firstIndex]
                                  ['description'] as String,
                                  rating: topVendors[firstIndex]['rating']
                                  as double,
                                  imageUrl: topVendors[firstIndex]['imageUrl']
                                  as String,
                                  onRequest: () => _onRequest(firstIndex),
                                ),
                              ),
                              if (secondIndex < topVendors.length) ...[
                                const SizedBox(width: 12),
                                Expanded(
                                  child: VendorRequestCard(
                                    name: topVendors[secondIndex]['name']
                                    as String,
                                    description: topVendors[secondIndex]
                                    ['description'] as String,
                                    rating: topVendors[secondIndex]['rating']
                                    as double,
                                    imageUrl: topVendors[secondIndex]
                                    ['imageUrl'] as String,
                                    onRequest: () => _onRequest(secondIndex),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios,
                size: 20, color: Color(0xFF1A1A1A)),
          ),
          const SizedBox(width: 12),
          const Text(
            'Community Requests',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}