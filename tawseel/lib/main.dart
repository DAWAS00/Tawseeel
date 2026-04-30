import 'package:flutter/material.dart';
import 'package:tawseel/screens/login_screen.dart';
import 'package:tawseel/screens/register_screen.dart';
import 'package:tawseel/screens/shop_owner_register_screen.dart';
import 'package:tawseel/screens/splash_screen.dart';
import 'package:tawseel/screens/homepage_screen.dart';

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
        '/register': (context) => const RegisterScreen(),
        '/shop-owner-register': (context) => const ShopOwnerRegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
