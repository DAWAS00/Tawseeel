import 'package:flutter/material.dart';
import '../models/vendor_model.dart';
import 'vendor_list_item.dart';

class RecentlyAddedSection extends StatelessWidget {
  final List<Vendor> vendors;
  final Function(Vendor) onVendorTap;

  const RecentlyAddedSection({
    super.key,
    required this.vendors,
    required this.onVendorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            'Recently Added',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        ...vendors.map((vendor) {
          return VendorListItem(
            vendor: vendor,
            onTap: () => onVendorTap(vendor),
          );
        }),
      ],
    );
  }
}
