import 'package:flutter/material.dart';

/// Logic controller for the Login Screen.
/// Handles form validation and navigation logic.
class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Validates the email/phone field.
  /// Returns an error message if invalid, otherwise null.
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or phone number';
    }
    return null;
  }

  /// Validates the password field.
  /// Returns an error message if invalid, otherwise null.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Handles the login action.
  /// If valid, navigates to the home screen using named routes.
  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        '/otp-verification',
        arguments: {'phone': emailController.text},
      );
    }
  }

  /// Disposes the controllers to free up memory.
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
