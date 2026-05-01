import 'package:flutter/material.dart';
import '../../core/constants.dart';
import 'login_controller.dart';
import 'widgets/merchant_login_header.dart';
import 'widgets/merchant_login_form.dart';
import 'widgets/merchant_login_footer.dart';

class MerchantLoginScreen extends StatefulWidget {
  const MerchantLoginScreen({super.key});

  @override
  State<MerchantLoginScreen> createState() => _MerchantLoginScreenState();
}

class _MerchantLoginScreenState extends State<MerchantLoginScreen> {
  final LoginController _controller = LoginController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const MerchantLoginHeader(),
            const SizedBox(height: 48),
            MerchantLoginForm(controller: _controller),
            const SizedBox(height: 32),
            const MerchantLoginFooter(),
          ],
        ),
      ),
    );
  }
}
