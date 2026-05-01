import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants.dart';

class MerchantLoginHeader extends StatelessWidget {
  const MerchantLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.storefront_rounded,
            color: AppColors.primary,
            size: 48,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Merchant Portal',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to manage your store',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            color: AppColors.textMid,
          ),
        ),
      ],
    );
  }
}
