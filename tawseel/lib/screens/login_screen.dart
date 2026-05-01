import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'login/login_controller.dart';
import 'login/widgets/login_header.dart';
import 'login/widgets/login_form.dart';
import 'login/widgets/vendor_login_button.dart';

/// The main Login Screen.
/// This file assembles the UI components and connects them to the logic controller.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Instance of the logic controller
  final LoginController _controller = LoginController();

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // UI: Header with Logo and Welcome text
                const LoginHeader(),
                
                const SizedBox(height: 48),
                
                // UI: Form with input fields and login button
                LoginForm(controller: _controller),
                
                const SizedBox(height: 32),

                // UI: Vendor Login Button (Static)
                const VendorLoginButton(),
                
                const SizedBox(height: 24),
                
                // UI: Optional Register/Guest section
                _buildOtherOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the "Register" and "Continue as Guest" options.
  Widget _buildOtherOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register', arguments: {'isCustomer': true}),
              child: const Text('Register Now', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
            const Text("Don't have an account?", style: TextStyle(color: AppColors.textMid)),
          ],
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Continue as Guest', style: TextStyle(color: AppColors.primary)),
        ),
      ],
    );
  }
}
