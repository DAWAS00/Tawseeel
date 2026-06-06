import 'package:flutter/material.dart';
import 'vendor_detail/vendor_detail_page.dart';

final List<Map<String, dynamic>> vendors = [
  {
    'name': 'Gourmet Burger Kitchen',
    'category': 'Restaurants',
    'price': 15,
    'time': '25-35 min',
    'rating': 4.5,
    'imageUrl':
    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
    'tag': 'Offer',
    'tagColor': Color(0xFFE65100),
  },
  {
    'name': 'The Artisan Bakery',
    'category': 'Bakery',
    'price': 8,
    'time': '15-25 min',
    'rating': 4.2,
    'imageUrl':
    'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&q=80',
    'tag': null,
    'tagColor': null,
  },
  {
    'name': 'Fresh Mart Hyper',
    'category': 'Grocery',
    'price': 45,
    'time': '45-90 min',
    'rating': 4.6,
    'imageUrl':
    'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80',
    'tag': null,
    'tagColor': null,
  },
  {
    'name': 'Sushi Palace',
    'category': 'Japanese',
    'price': 25,
    'time': '30-45 min',
    'rating': 4.8,
    'imageUrl':
    'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=400&q=80',
    'tag': 'Popular',
    'tagColor': Color(0xFF1A73E8),
  },
];

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A73E8) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A73E8) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}

class VendorCard extends StatelessWidget {
  final String name;
  final String category;
  final int price;
  final String time;
  final double rating;
  final String imageUrl;
  final String? tag;
  final Color? tagColor;
  final VoidCallback onTap;

  const VendorCard({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.time,
    required this.rating,
    required this.imageUrl,
    required this.onTap,
    this.tag,
    this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 160,
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
                        height: 160,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image,
                            color: Colors.grey, size: 40),
                      );
                    },
                  ),
                ),
                if (tag != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.favorite_border,
                        size: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0xFFFFC107), size: 16),
                          const SizedBox(width: 3),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.attach_money,
                          size: 14, color: Colors.grey.shade500),
                      Text(
                        '$price JD min',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade500),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.access_time,
                          size: 14, color: Colors.grey.shade500),
                      const SizedBox(width: 3),
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  int _selectedFilter = 0;

  final List<String> _filters = [
    'All',
    'Restaurants',
    'Bakery',
    'Grocery',
    'Japanese',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildFilters(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Featured Vendors',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...vendors.map((vendor) {
                      return VendorCard(
                        name: vendor['name'] as String,
                        category: vendor['category'] as String,
                        price: vendor['price'] as int,
                        time: vendor['time'] as String,
                        rating: vendor['rating'] as double,
                        imageUrl: vendor['imageUrl'] as String,
                        tag: vendor['tag'] as String?,
                        tagColor: vendor['tagColor'] as Color?,
                        onTap: () {
                          // Navigate to the vendor's menu page when the user taps a card
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VendorDetailPage(
                                vendorName: vendor['name'] as String,
                                category: vendor['category'] as String,
                                imageUrl: vendor['imageUrl'] as String,
                                rating: vendor['rating'] as double,
                                deliveryTime: vendor['time'] as String,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    const SizedBox(height: 20),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on,
                      color: Color(0xFF1A73E8), size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),
              const Text(
                'Vendors',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06), blurRadius: 8),
              ],
            ),
            child: const Icon(Icons.tune, color: Color(0xFF1A73E8), size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06), blurRadius: 8),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search a vendor or item...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 42,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: List.generate(_filters.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChipWidget(
                label: _filters[index],
                isSelected: _selectedFilter == index,
                onTap: () {
                  setState(() {
                    _selectedFilter = index;
                  });
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}