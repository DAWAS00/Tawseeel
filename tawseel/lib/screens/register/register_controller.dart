import 'package:flutter/material.dart';

class RegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Shop Owner Fields
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController googleMapsController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController restaurantEmailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your full name';
    return null;
  }

  String? validateBusinessName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter business name';
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter detailed address';
    return null;
  }

  String? validateGoogleMaps(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter Google Maps link';
    return null;
  }

  String? validateOwnerName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter owner name';
    return null;
  }

  String? validateRestaurantEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter restaurant email';
    if (!value.contains('@')) return 'Invalid email address';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your phone number';
    if (value.length < 7) return 'Invalid phone number';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return null; // optional
    if (!value.contains('@')) return 'Invalid email address';
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

  void register(BuildContext context, {required bool acceptedTerms}) {
    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms & Conditions')),
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    businessNameController.dispose();
    addressController.dispose();
    googleMapsController.dispose();
    ownerNameController.dispose();
    restaurantEmailController.dispose();
  }
}
