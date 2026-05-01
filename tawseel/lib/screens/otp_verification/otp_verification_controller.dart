import 'dart:async';
import 'package:flutter/material.dart';

class OtpVerificationController {
  static const int otpLength = 6;
  static const int countdownSeconds = 90;

  final List<TextEditingController> boxControllers =
      List.generate(otpLength, (_) => TextEditingController());
  final List<FocusNode> focusNodes =
      List.generate(otpLength, (_) => FocusNode());

  int secondsRemaining = countdownSeconds;
  bool canResend = false;
  Timer? _timer;

  void Function(void Function())? onStateChanged;

  void startCountdown() {
    _timer?.cancel();
    secondsRemaining = countdownSeconds;
    canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining <= 0) {
        t.cancel();
        canResend = true;
      } else {
        secondsRemaining--;
      }
      onStateChanged?.call(() {});
    });
  }

  String get countdownLabel {
    final m = secondsRemaining ~/ 60;
    final s = secondsRemaining % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  String get fullOtp => boxControllers.map((c) => c.text).join();

  void handleInput(int index, String value, BuildContext context) {
    if (value.length == 1 && index < otpLength - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
    // If pasted full OTP
    if (value.length == otpLength) {
      for (int i = 0; i < otpLength; i++) {
        boxControllers[i].text = value[i];
      }
      FocusScope.of(context).unfocus();
    }
  }

  void handleBackspace(int index, BuildContext context) {
    if (boxControllers[index].text.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      boxControllers[index - 1].clear();
    }
  }

  void verify(BuildContext context) {
    final otp = fullOtp;
    if (otp.length < otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete 6-digit code.')),
      );
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  void resend(BuildContext context) {
    if (!canResend) return;
    for (final c in boxControllers) {
      c.clear();
    }
    FocusScope.of(context).requestFocus(focusNodes[0]);
    startCountdown();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('A new code has been sent.')),
    );
  }

  void dispose() {
    _timer?.cancel();
    for (final c in boxControllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
  }
}
