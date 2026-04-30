import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants.dart';
import 'shop_owner_register/shop_owner_register_controller.dart';
import 'shop_owner_register/widgets/shop_owner_register_form.dart';

class ShopOwnerRegisterScreen extends StatefulWidget {
  const ShopOwnerRegisterScreen({super.key});

  @override
  State<ShopOwnerRegisterScreen> createState() => _ShopOwnerRegisterScreenState();
}

class _ShopOwnerRegisterScreenState extends State<ShopOwnerRegisterScreen> {
  final _controller = ShopOwnerRegisterController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Decorative gradient top accent
          Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary, AppColors.primary],
              ),
            ),
          ),
          _appBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                children: [
                  _rolePill(),
                  const SizedBox(height: 24),
                  ShopOwnerRegisterForm(controller: _controller),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _footer(),
    );
  }

  // ─── Role Toggle Pill ────────────────────────────────────────────
  Widget _rolePill() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(9999),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2), spreadRadius: 0)],
      ),
      child: Row(
        children: [
          // Shop Owner — active
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(9999),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 4), spreadRadius: -3),
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 4), spreadRadius: -4),
                ],
              ),
              child: Center(
                child: Text(
                  'Shop Owner',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Customer — tapping navigates to the standard register screen
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/register'),
              child: Center(
                child: Text(
                  'Customer',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMid,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Custom AppBar ───────────────────────────────────────────────
  Widget _appBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.8),
        border: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand name
          Text(
            'Tawseel',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: -0.4,
            ),
          ),
          // Title + back button
          Row(
            children: [
              Text(
                'Create New Account',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4, offset: const Offset(0, 1))],
                  ),
                  child: const Icon(Icons.arrow_forward_rounded, size: 18, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Sticky footer ───────────────────────────────────────────────
  Widget _footer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.92),
        border: const Border(top: BorderSide(color: Color(0xFFE2E8F0), width: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Create Account button
          GestureDetector(
            onTap: () => _controller.register(context),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.71, -0.71),
                  end: Alignment(0.71, 0.71),
                  colors: [AppColors.primary, Color(0xFF003DAA)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withOpacity(0.2), offset: const Offset(0, 10), blurRadius: 15, spreadRadius: -3),
                  BoxShadow(color: AppColors.primary.withOpacity(0.2), offset: const Offset(0, 4), blurRadius: 6, spreadRadius: -4),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.storefront_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Create Account',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Sign in link
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?  ',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF737686),
                    ),
                  ),
                  Text(
                    'Sign In',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
