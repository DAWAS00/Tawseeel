import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants.dart';
import '../register_controller.dart';

class RegisterForm extends StatefulWidget {
  final RegisterController controller;
  const RegisterForm({super.key, required this.controller});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isCustomer = true;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptedTerms = true;
  int _strengthSegments = 0;

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
          const SizedBox(height: 20),
          _field(
            label: 'Full Name',
            child: _input(
              controller: widget.controller.nameController,
              hint: 'Enter your full name',
              textDirection: TextDirection.ltr,
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
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.emailAddress,
              validator: widget.controller.validateEmail,
            ),
          ),
          const SizedBox(height: 16),
          _field(
            label: 'Password',
            child: Column(
              children: [
                _input(
                  controller: widget.controller.passwordController,
                  hint: '••••••••',
                  textDirection: TextDirection.ltr,
                  obscure: _obscurePassword,
                  validator: widget.controller.validatePassword,
                  onChanged: _onPasswordChanged,
                  suffix: GestureDetector(
                    onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
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
              textDirection: TextDirection.ltr,
              obscure: _obscureConfirm,
              validator: widget.controller.validateConfirm,
              suffix: GestureDetector(
                onTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
                child: Icon(
                  _obscureConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textLight,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _termsRow(),
          const SizedBox(height: 20),
          _createAccountButton(),
          const SizedBox(height: 24),
          _signInLink(),
        ],
      ),
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
      ),
      child: Row(
        children: [
          Expanded(child: _pillOption(label: 'CUSTOMER', active: _isCustomer, onTap: () => setState(() => _isCustomer = true))),
          Expanded(child: _pillOption(label: 'SHOP OWNER', active: !_isCustomer, onTap: () => Navigator.pushReplacementNamed(context, '/shop-owner-register'))),
        ],
      ),
    );
  }

  Widget _pillOption({
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: active ? Colors.white : AppColors.textMid,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Field with English label ──────────────────────────────────
  Widget _field({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  // ─── Pill-style input ────────────────────────────────────────────
  Widget _input({
    required TextEditingController controller,
    required String hint,
    required TextDirection textDirection,
    bool obscure = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      textDirection: textDirection,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF6B7280),
        ),
        suffixIcon: suffix != null ? Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: suffix) : null,
        suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }

  // ─── Phone row: country code + number input ──────────────────────
  Widget _phoneRow() {
    return Row(
      children: [
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(48),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 1), blurRadius: 1)],
          ),
          child: Center(
            child: Text(
              '+962',
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: widget.controller.phoneController,
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.phone,
            validator: widget.controller.validatePhone,
            decoration: InputDecoration(
              hintText: '7XXXXXXXX',
              hintStyle: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(48), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(48), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(48), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(48), borderSide: const BorderSide(color: AppColors.error)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(48), borderSide: const BorderSide(color: AppColors.error)),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Password strength bar ───────────────────────────────────────
  Widget _strengthBar() {
    return Row(
      children: List.generate(4, (i) {
        final active = i < _strengthSegments;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : const Color(0xFFEDEEF2),
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
        );
      }),
    );
  }

  // ─── Shop owner info banner ──────────────────────────────────────
  Widget _shopOwnerBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Your details will be reviewed and we'll contact you",
              textAlign: TextAlign.left,
              style: GoogleFonts.cairo(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Terms & Conditions row ──────────────────────────────────────
  Widget _termsRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _acceptedTerms ? AppColors.primary : Colors.white,
              border: Border.all(
                color: _acceptedTerms ? AppColors.primary : AppColors.border,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _acceptedTerms
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            children: [
              Text(
                'I agree to the ',
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Terms & Conditions',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Create Account button ───────────────────────────────────────
  Widget _createAccountButton() {
    return GestureDetector(
      onTap: () => widget.controller.register(context, acceptedTerms: _acceptedTerms),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-0.71, -0.71),
            end: Alignment(0.71, 0.71),
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.2), offset: const Offset(0, 10), blurRadius: 15, spreadRadius: -3),
            BoxShadow(color: AppColors.primary.withOpacity(0.2), offset: const Offset(0, 4), blurRadius: 6, spreadRadius: -4),
          ],
        ),
        child: Center(
          child: Text(
            'Create Account',
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Sign in link ────────────────────────────────────────────────
  Widget _signInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Sign In',
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
