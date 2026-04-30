import 'package:flutter/material.dart';

class ShopOwnerRegisterController {
  // Business Details
  final storeNameController = TextEditingController();
  final businessNameEnController = TextEditingController();

  // Business Address
  final addressController = TextEditingController();
  final mapsLinkController = TextEditingController();

  // Owner Info
  final ownerNameController = TextEditingController();
  final phoneController = TextEditingController();

  // Account Details
  final emailController = TextEditingController();
  String? selectedCategory;
  String? selectedCity;

  // Payment
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  // Passwords
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    if (!value.contains('@')) return 'Invalid email address';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter phone number';
    if (value.length < 7) return 'Invalid phone number';
    return null;
  }

  String? validateCard(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter card number';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateConfirm(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  void register(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void dispose() {
    storeNameController.dispose();
    businessNameEnController.dispose();
    addressController.dispose();
    mapsLinkController.dispose();
    ownerNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
