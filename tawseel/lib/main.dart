import 'package:flutter/material.dart';
import 'package:tawseel/screens/login_screen.dart';
import 'package:tawseel/screens/register_screen.dart';
import 'package:tawseel/screens/splash_screen.dart';
import 'package:tawseel/screens/home/home_screen.dart';
import 'package:tawseel/screens/forgot_password_screen.dart';
import 'package:tawseel/screens/otp_verification_screen.dart';
import 'package:tawseel/screens/login/merchant_login_screen.dart';
import 'package:tawseel/screens/vendor_screen.dart';
import 'package:tawseel/screens/requests.dart';
import 'package:tawseel/screens/user_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/merchant-login': (context) => const MerchantLoginScreen(),
        '/register': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return RegisterScreen(initialIsCustomer: args?['isCustomer'] ?? true);
        },
        '/home': (context) => const HomeScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/otp-verification': (context) => const OtpVerificationScreen(),
        '/vendors': (context) => const VendorScreen(),
        '/requests': (context) => const RequestingPage(),
        '/profile': (context) => const UserProfileScreen(),
      },
    );
  }
}
