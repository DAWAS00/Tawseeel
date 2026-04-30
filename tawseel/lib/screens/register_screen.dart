import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants.dart';
import 'register/register_controller.dart';
import 'register/widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController _controller = RegisterController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Tawseel',
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: -0.45,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _screenTitle(),
              const SizedBox(height: 20),
              RegisterForm(controller: _controller),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _screenTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create New Account',
          style: GoogleFonts.cairo(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        Text(
          'Fill in your details to get started',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textMid,
          ),
        ),
      ],
    );
  }
}
