import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants.dart';

class MerchantLoginFooter extends StatelessWidget {
  const MerchantLoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have a business account?",
          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textMid),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/register', arguments: {'isCustomer': false}),
          child: Text(
            'Register',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
