import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants.dart';
import '../register_controller.dart';

const _categories = [
  'Grocery', 'Restaurant', 'Pharmacy', 'Electronics',
  'Clothing', 'Beauty & Care', 'Books & Stationery', 'Sports', 'Other',
];

const _cities = [
  'Amman', 'Zarqa', 'Irbid', 'Aqaba',
  'Madaba', 'Salt', 'Karak', 'Mafraq', 'Jerash',
];

class RegisterForm extends StatefulWidget {
  final RegisterController controller;
  final bool initialIsCustomer;
  const RegisterForm({super.key, required this.controller, this.initialIsCustomer = true});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late bool _isCustomer;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptedTerms = true;
  bool _isLoading = false;
  int _strengthSegments = 0;

  @override
  void initState() {
    super.initState();
    _isCustomer = widget.initialIsCustomer;
  }

  void _onPasswordChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _strengthSegments = 0;
      } else if (value.length < 4) {
        _strengthSegments = 1;
      } else if (value.length < 8) {
        _strengthSegments = 2;
      } else if (value.length < 12) {
        _strengthSegments = 3;
      } else {
        _strengthSegments = 4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _rolePill(),
          const SizedBox(height: 24),
          if (_isCustomer) _customerFields() else _shopOwnerFields(),
          const SizedBox(height: 16),
          _termsRow(),
          const SizedBox(height: 24),
          _createAccountButton(),
          const SizedBox(height: 24),
          _signInLink(),
        ],
      ),
    );
  }

  // ─── Customer View ──────────────────────────────────────────────
  Widget _customerFields() {
    return Column(
      children: [
        _field(
          label: 'Full Name',
          child: _input(
            controller: widget.controller.nameController,
            hint: 'Enter your full name',
            validator: widget.controller.validateName,
          ),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Phone Number',
          child: _phoneRow(),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Email',
          child: _input(
            controller: widget.controller.emailController,
            hint: 'example@mail.com',
            keyboardType: TextInputType.emailAddress,
            validator: widget.controller.validateEmail,
          ),
        ),
        const SizedBox(height: 16),
        _passwordsSection(),
      ],
    );
  }

  // ─── Shop Owner View ────────────────────────────────────────────
  Widget _shopOwnerFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Business Details'),
        const SizedBox(height: 12),
        _field(
          label: 'Business Name',
          child: _input(
            controller: widget.controller.businessNameController,
            hint: 'Enter restaurant or shop name',
            validator: widget.controller.validateBusinessName,
          ),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Owner Name',
          child: _input(
            controller: widget.controller.nameController,
            hint: 'Enter full name of the owner',
            validator: widget.controller.validateName,
          ),
        ),
        const SizedBox(height: 24),
        _sectionLabel('Contact & Location'),
        const SizedBox(height: 12),
        _field(
          label: 'Phone Number',
          child: _phoneRow(),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Email',
          child: _input(
            controller: widget.controller.emailController,
            hint: 'business@example.com',
            keyboardType: TextInputType.emailAddress,
            validator: widget.controller.validateEmail,
          ),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Detailed Address',
          child: _input(
            controller: widget.controller.addressController,
            hint: 'Street, building, area...',
            validator: widget.controller.validateAddress,
          ),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Google Maps Link',
          child: _input(
            controller: widget.controller.googleMapsController,
            hint: 'https://maps.app.goo.gl/...',
            validator: widget.controller.validateGoogleMaps,
          ),
        ),
        const SizedBox(height: 24),
        _sectionLabel('Account Details'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _field(
                label: 'Category',
                child: _dropdown(
                  hint: 'Select category',
                  items: _categories,
                  value: widget.controller.selectedCategory,
                  onChanged: (v) => setState(() => widget.controller.selectedCategory = v),
                  icon: Icons.storefront_outlined,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _field(
                label: 'City',
                child: _dropdown(
                  hint: 'Select city',
                  items: _cities,
                  value: widget.controller.selectedCity,
                  onChanged: (v) => setState(() => widget.controller.selectedCity = v),
                  icon: Icons.location_on_outlined,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Verification'),
        const SizedBox(height: 12),
        _uploadSection(),
        const SizedBox(height: 24),
        _sectionLabel('Security'),
        const SizedBox(height: 12),
        _passwordsSection(),
      ],
    );
  }

  // ─── Shared Components ──────────────────────────────────────────
  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _passwordsSection() {
    return Column(
      children: [
        _field(
          label: 'Password',
          child: Column(
            children: [
              _input(
                controller: widget.controller.passwordController,
                hint: '••••••••',
                obscure: _obscurePassword,
                validator: widget.controller.validatePassword,
                onChanged: _onPasswordChanged,
                suffix: GestureDetector(
                  onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.textLight,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _strengthBar(),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Confirm Password',
          child: _input(
            controller: widget.controller.confirmPasswordController,
            hint: '••••••••',
            obscure: _obscureConfirm,
            validator: widget.controller.validateConfirm,
            suffix: GestureDetector(
              onTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
              child: Icon(
                _obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColors.textLight,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rolePill() {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _pillOption(label: 'CUSTOMER', active: _isCustomer, onTap: () => setState(() => _isCustomer = true))),
          Expanded(child: _pillOption(label: 'SHOP OWNER', active: !_isCustomer, onTap: () => setState(() => _isCustomer = false))),
        ],
      ),
    );
  }

  Widget _pillOption({required String label, required bool active, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: active ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))] : null,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: active ? Colors.white : AppColors.textMid,
            ),
          ),
        ),
      ),
    );
  }

  Widget _field({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      style: GoogleFonts.plusJakartaSans(fontSize: 15, color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textLight),
        suffixIcon: suffix != null ? Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: suffix) : null,
        suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
      ),
    );
  }

  Widget _phoneRow() {
    return Row(
      children: [
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '+962',
              style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: widget.controller.phoneController,
            keyboardType: TextInputType.phone,
            validator: widget.controller.validatePhone,
            decoration: InputDecoration(
              hintText: '7XXXXXXXX',
              hintStyle: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textLight),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _strengthBar() {
    return Row(
      children: List.generate(4, (i) {
        final active = i < _strengthSegments;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _uploadSection() {
    return GestureDetector(
      onTap: () {},
      child: CustomPaint(
        painter: _DashedBorderPainter(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Icon(Icons.cloud_upload_outlined, color: AppColors.primary, size: 32),
              const SizedBox(height: 8),
              Text(
                'Upload Trade License or ID',
                style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
              ),
              Text(
                'Max size: 5MB (PDF, JPG, PNG)',
                style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textMid),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _termsRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _acceptedTerms ? AppColors.primary : Colors.white,
              border: Border.all(color: _acceptedTerms ? AppColors.primary : AppColors.border),
              borderRadius: BorderRadius.circular(6),
            ),
            child: _acceptedTerms ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'I agree to the Terms & Conditions',
            style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textMid),
          ),
        ),
      ],
    );
  }

  Widget _createAccountButton() {
    return ElevatedButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() => _isLoading = true);
              await widget.controller.register(
                context,
                acceptedTerms: _acceptedTerms,
                isCustomer: _isCustomer,
              );
              if (mounted) setState(() => _isLoading = false);
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            )
          : Text(
              'Create Account',
              style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _signInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textMid),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Sign In',
            style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _dropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textLight)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textLight),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.plusJakartaSans(fontSize: 13)))).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC3C6D7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)));

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, min(distance + dashWidth, metric.length)), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) => false;
}
