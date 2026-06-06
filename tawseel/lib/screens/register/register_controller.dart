import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController {
  // Shared Fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Shop Owner Specific Fields
  final businessNameController = TextEditingController();
  final addressController = TextEditingController();
  final googleMapsController = TextEditingController();

  // Payment Information
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  // Account Details (Shop Owner)
  String? selectedCategory;
  String? selectedCity;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Validations
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

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your phone number';
    if (value.length < 7) return 'Invalid phone number';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
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

  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }

  String? validateCard(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter card number';
    return null;
  }

  Future<void> register(
    BuildContext context, {
    required bool acceptedTerms,
    required bool isCustomer,
  }) async {
    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms & Conditions')),
      );
      return;
    }
    if (!formKey.currentState!.validate()) return;

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final user = response.user;
      if (user == null) return;

      await Supabase.instance.client.from('profiles').insert({
        'id': user.id,
        'name': nameController.text.trim(),
        'phone': '+962${phoneController.text.trim()}',
        'role': isCustomer ? 'customer' : 'vendor',
      });

      if (!isCustomer) {
        await Supabase.instance.client.from('vendors').insert({
          'id': user.id,
          'business_name': businessNameController.text.trim(),
          'address': addressController.text.trim(),
          'google_maps_link': googleMapsController.text.trim(),
          'category': selectedCategory,
          'city': selectedCity,
        });
      }

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } on PostgrestException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
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
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
  }
}
