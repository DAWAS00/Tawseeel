import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // i will put the logo here
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.local_shipping,
                size: 80,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Tawseel',
              style: GoogleFonts.cairo(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                letterSpacing: 1.2,
              ),
            ),
            Container(
              height: 2,
              width: 40,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 20),
            ),
            Text(
              'Your neighborhood at your fingertips',
              style: GoogleFonts.cairo(
                fontSize: 16,
                color: Colors.blueAccent.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
