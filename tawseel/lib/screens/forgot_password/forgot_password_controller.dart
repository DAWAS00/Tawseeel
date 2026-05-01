import 'package:flutter/material.dart';

class ForgotPasswordController {
  final emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email or phone';
    return null;
  }

  void sendResetLink(BuildContext context) {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reset link sent! Check your inbox.')),
      );
    }
  }

  void dispose() {
    emailController.dispose();
  }
}
