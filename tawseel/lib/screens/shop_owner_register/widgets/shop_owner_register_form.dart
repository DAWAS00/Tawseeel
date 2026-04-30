import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants.dart';
import '../shop_owner_register_controller.dart';

// ─── Card number formatter (inserts space every 4 digits) ────────
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue old, TextEditingValue next) {
    final digits = next.text.replaceAll(' ', '');
    if (digits.length > 16) return old;
    final buf = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buf.write(' ');
      buf.write(digits[i]);
    }
    final text = buf.toString();
    return TextEditingValue(text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

// ─── Expiry formatter (auto-inserts "/" after MM) ─────────────────
class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue old, TextEditingValue next) {
    var digits = next.text.replaceAll('/', '');
    if (digits.length > 4) return old;
    if (digits.length >= 3) digits = '${digits.substring(0, 2)}/${digits.substring(2)}';
    return TextEditingValue(text: digits, selection: TextSelection.collapsed(offset: digits.length));
  }
}

const _categories = [
  'Grocery', 'Restaurant', 'Pharmacy', 'Electronics',
  'Clothing', 'Beauty & Care', 'Books & Stationery', 'Sports', 'Other',
];

const _cities = [
  'Amman', 'Zarqa', 'Irbid', 'Aqaba',
  'Madaba', 'Salt', 'Karak', 'Mafraq', 'Jerash',
];

class ShopOwnerRegisterForm extends StatefulWidget {
  final ShopOwnerRegisterController controller;
  const ShopOwnerRegisterForm({super.key, required this.controller});

  @override
  State<ShopOwnerRegisterForm> createState() => _ShopOwnerRegisterFormState();
}

class _ShopOwnerRegisterFormState extends State<ShopOwnerRegisterForm> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  double _strengthPercent = 0;

  void _onPasswordChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _strengthPercent = 0;
      } else if (value.length < 4) {
        _strengthPercent = 0.25;
      } else if (value.length < 8) {
        _strengthPercent = 0.5;
      } else if (value.length < 12) {
        _strengthPercent = 0.75;
      } else {
        _strengthPercent = 1.0;
      }
    });
  }

  Color get _strengthColor {
    if (_strengthPercent <= 0.25) return Colors.redAccent;
    if (_strengthPercent <= 0.5) return const Color(0xFFE8970C);
    if (_strengthPercent <= 0.75) return const Color(0xFF3B82F6);
    return const Color(0xFF22C55E);
  }

  String get _strengthLabel {
    if (_strengthPercent == 0) return '';
    if (_strengthPercent <= 0.25) return 'Weak password';
    if (_strengthPercent <= 0.5) return 'Medium password';
    if (_strengthPercent <= 0.75) return 'Good password';
    return 'Strong password';
  }

  Color get _strengthLabelColor {
    if (_strengthPercent <= 0.25) return Colors.redAccent;
    if (_strengthPercent <= 0.5) return const Color(0xFFE8970C);
    if (_strengthPercent <= 0.75) return const Color(0xFF3B82F6);
    return const Color(0xFF16A34A);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Business Details'),
          const SizedBox(height: 12),
          _businessDetails(),
          const SizedBox(height: 28),
          _sectionLabel('Business Address'),
          const SizedBox(height: 12),
          _businessAddress(),
          const SizedBox(height: 28),
          _sectionLabel('Owner Information'),
          const SizedBox(height: 12),
          _ownerInfo(),
          const SizedBox(height: 28),
          _sectionLabel('Verification Document'),
          const SizedBox(height: 12),
          _verificationSection(),
          const SizedBox(height: 28),
          _sectionLabel('Account Details'),
          const SizedBox(height: 12),
          _accountDetails(),
          const SizedBox(height: 28),
          _sectionLabel('Payment Information'),
          const SizedBox(height: 12),
          _paymentInfo(),
          const SizedBox(height: 28),
          _sectionLabel('Password'),
          const SizedBox(height: 12),
          _passwords(),
          const SizedBox(height: 20),
          _infoBanner(),
        ],
      ),
    );
  }

  // ─── Section label ───────────────────────────────────────────────
  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark.withOpacity(0.5),
        letterSpacing: 0.5,
      ),
    );
  }

  // ─── Business Details ────────────────────────────────────────────
  Widget _businessDetails() {
    return Column(
      children: [
        _field(
          label: 'Store Name (Arabic)',
          child: _input(
            controller: widget.controller.storeNameController,
            hint: 'Enter store name',
            validator: widget.controller.validateRequired,
          ),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Business Name (English)',
          child: _input(
            controller: widget.controller.businessNameEnController,
            hint: 'Enter business name',
            validator: widget.controller.validateRequired,
          ),
        ),
      ],
    );
  }

  // ─── Business Address ────────────────────────────────────────────
  Widget _businessAddress() {
    return Column(
      children: [
        _field(
          label: 'Detailed Address',
          child: _input(
            controller: widget.controller.addressController,
            hint: 'Street, building, landmark',
            validator: widget.controller.validateRequired,
          ),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Google Maps Link',
          child: _input(
            controller: widget.controller.mapsLinkController,
            hint: 'https://maps.app.goo.gl/...',
            keyboardType: TextInputType.url,
          ),
        ),
      ],
    );
  }

  // ─── Owner Info ──────────────────────────────────────────────────
  Widget _ownerInfo() {
    return Column(
      children: [
        _field(
          label: 'Owner Name',
          child: _input(
            controller: widget.controller.ownerNameController,
            hint: 'Full name',
            validator: widget.controller.validateRequired,
          ),
        ),
        const SizedBox(height: 16),
        _field(
          label: 'Phone Number',
          child: Row(
            children: [
              // Number input
              Expanded(
                child: TextFormField(
                  controller: widget.controller.phoneController,
                  keyboardType: TextInputType.phone,
                  validator: widget.controller.validatePhone,
                  style: GoogleFonts.plusJakartaSans(fontSize: 16, color: AppColors.textDark),
                  decoration: InputDecoration(
                    hintText: '7XXXXXXXX',
                    hintStyle: GoogleFonts.plusJakartaSans(fontSize: 16, color: const Color(0xFF6B7280)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Country code badge
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 1), blurRadius: 1)],
                ),
                child: Center(
                  child: Text(
                    '+962',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Upload dialog ───────────────────────────────────────────────
  void _showUploadDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Upload Document',
              style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark),
            ),
            const SizedBox(height: 4),
            Text(
              'Trade license or national ID (max 5MB)',
              style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textMid),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _uploadOption(Icons.photo_camera_outlined, 'Camera')),
                const SizedBox(width: 12),
                Expanded(child: _uploadOption(Icons.photo_library_outlined, 'Gallery')),
                const SizedBox(width: 12),
                Expanded(child: _uploadOption(Icons.folder_outlined, 'Files')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _uploadOption(IconData icon, String label) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 6),
            Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ],
        ),
      ),
    );
  }

  // ─── Verification / File upload ──────────────────────────────────
  Widget _verificationSection() {
    return Column(
      children: [
        _field(
          label: 'Trade License or ID',
          child: GestureDetector(
            onTap: _showUploadDialog,
            child: CustomPaint(
              painter: _DashedBorderPainter(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 26),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(48),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_upload_outlined, color: AppColors.primary, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'Tap to upload',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Max size: 5MB  (PDF, JPG, PNG)',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: const Color(0xFF737686),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, color: Color(0xFF434655), size: 14),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Help us verify your business to build trust with customers',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: const Color(0xFF434655).withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Account Details ─────────────────────────────────────────────
  Widget _accountDetails() {
    return Column(
      children: [
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
        Row(
          children: [
            Expanded(
              child: _field(
                label: 'Store Category',
                child: _dropdown(
                  hint: 'Select category',
                  items: _categories,
                  value: widget.controller.selectedCategory,
                  onChanged: (v) => setState(() => widget.controller.selectedCategory = v),
                  icon: Icons.storefront_outlined,
                  validator: (v) => v == null ? 'Required' : null,
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
                  validator: (v) => v == null ? 'Required' : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Payment Info ────────────────────────────────────────────────
  Widget _paymentInfo() {
    return Column(
      children: [
        _field(
          label: 'Card Number',
          child: _inputWithPrefixIcon(
            controller: widget.controller.cardNumberController,
            hint: '0000 0000 0000 0000',
            icon: Icons.credit_card_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, _CardNumberFormatter()],
            validator: widget.controller.validateCard,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _field(
                label: 'Expiry Date',
                child: _input(
                  controller: widget.controller.expiryController,
                  hint: 'MM/YY',
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, _ExpiryFormatter()],
                  textAlign: TextAlign.center,
                  validator: (v) => (v == null || v.length < 5) ? 'Invalid date' : null,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _field(
                label: 'CVV',
                child: _input(
                  controller: widget.controller.cvvController,
                  hint: '123',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                  textAlign: TextAlign.center,
                  validator: (v) => (v == null || v.length < 3) ? 'Invalid CVV' : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.lock_outline, color: Color(0xFF737686), size: 12),
            const SizedBox(width: 4),
            Text(
              'For service fees and payouts',
              style: GoogleFonts.plusJakartaSans(fontSize: 10, color: const Color(0xFF737686)),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Passwords ───────────────────────────────────────────────────
  Widget _passwords() {
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
              if (_strengthPercent > 0) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: _strengthPercent,
                    backgroundColor: const Color(0xFFE7E8EC),
                    valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _strengthLabel,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _strengthLabelColor,
                    ),
                  ),
                ),
              ],
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

  // ─── Info Banner ─────────────────────────────────────────────────
  Widget _infoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your details will be reviewed and we\'ll contact you',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Our team will verify your information within 24–48 hours.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.primary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Shared: field with label ────────────────────────────────────
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

  // ─── Shared: rounded-12 card-style input ─────────────────────────
  Widget _input({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    Widget? suffix,
    TextAlign textAlign = TextAlign.left,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 1), blurRadius: 1)],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        textAlign: textAlign,
        style: GoogleFonts.plusJakartaSans(fontSize: 16, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.plusJakartaSans(fontSize: 16, color: const Color(0xFF6B7280).withOpacity(0.5)),
          suffixIcon: suffix != null
              ? Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: suffix)
              : null,
          suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
        ),
      ),
    );
  }

  // ─── Input with leading icon ──────────────────────────────────────
  Widget _inputWithPrefixIcon({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 1), blurRadius: 1)],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        style: GoogleFonts.plusJakartaSans(fontSize: 16, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.plusJakartaSans(fontSize: 16, color: const Color(0xFF6B7280)),
          prefixIcon: Icon(icon, color: AppColors.textLight, size: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
        ),
      ),
    );
  }

  // ─── Styled dropdown ─────────────────────────────────────────────
  Widget _dropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 1), blurRadius: 1)],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        validator: validator,
        hint: Row(
          children: [
            Icon(icon, color: AppColors.textLight, size: 16),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                hint,
                style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF6B7280)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textLight),
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
        ),
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textDark)),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

// ─── Dashed border painter ────────────────────────────────────────
class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC3C6D7)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
    final path = Path()..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(48)));

    const dashWidth = 8.0;
    const dashSpace = 5.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, min(distance + dashWidth, metric.length)),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) => false;
}
