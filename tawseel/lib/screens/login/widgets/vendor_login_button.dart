import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants.dart';

/// A static button for vendor login.
class VendorLoginButton extends StatelessWidget {
  const VendorLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/shop-owner-register'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.vendorBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.vendorIcon.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            // Restaurant/Store Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.vendorIcon.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.storefront,
                color: AppColors.vendorIcon,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you a shop owner?',
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      color: AppColors.vendorText,
                    ),
                  ),
                  Text(
                    'Merchant Register',
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.vendorIcon,
                    ),
                  ),
                ],
              ),
            ),
            // Trailing Arrow
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.vendorIcon,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
