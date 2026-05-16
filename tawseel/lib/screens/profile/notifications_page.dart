import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool appNotif = true;
  bool smsNotif = true;
  bool emailNotif = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
        title: const Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _toggle(
                icon: Icons.phone_android_outlined,
                label: 'App Notifications',
                value: appNotif,
                onChanged: (v) => setState(() => appNotif = v),
              ),
              Divider(height: 1, indent: 64, color: Colors.grey.shade100),
              _toggle(
                icon: Icons.sms_outlined,
                label: 'SMS Notifications',
                value: smsNotif,
                onChanged: (v) => setState(() => smsNotif = v),
              ),
              Divider(height: 1, indent: 64, color: Colors.grey.shade100),
              _toggle(
                icon: Icons.email_outlined,
                label: 'Email Notifications',
                value: emailNotif,
                onChanged: (v) => setState(() => emailNotif = v),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggle({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFF1A73E8).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF1A73E8), size: 20),
      ),
      title: Text(label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1A1A))),
      trailing: Switch(
        value: value,
        activeColor: const Color(0xFF1A73E8),
        onChanged: onChanged,
      ),
    );
  }
}
