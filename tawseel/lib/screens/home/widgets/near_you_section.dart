import 'package:flutter/material.dart';
import '../models/vendor_model.dart';
import 'near_you_card.dart';

class NearYouSection extends StatelessWidget {
  final List<Vendor> vendors;

  const NearYouSection({
    super.key,
    required this.vendors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Near You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: vendors.map((vendor) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: NearYouCard(vendor: vendor),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
