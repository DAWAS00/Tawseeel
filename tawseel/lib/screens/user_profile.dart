import 'package:flutter/material.dart';
import 'profile/edit_profile_page.dart';
import 'profile/orders_page.dart';
import 'profile/payment_page.dart';
import 'profile/notifications_page.dart';
import 'profile/privacy_page.dart';

class UserProfileScreen extends StatefulWidget {
  final bool showBackButton;

  const UserProfileScreen({super.key, this.showBackButton = true});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final String userName = 'Ahmed Hassan';
  final String email = 'ahmed@example.com';
  final String phone = '0791234567';
  final int points = 450;
  final double totalSpending = 1200;
  final int totalOrders = 24;

  void _onLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false); // Navigate to login
            },
            child: const Text('Log Out',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _push(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildSection('ACCOUNT', [
              _item(Icons.person_outline, 'Edit Personal Info',
                  onTap: () => _push(EditProfilePage(
                        userName: userName,
                        email: email,
                        phone: phone,
                      ))),
              _item(Icons.receipt_long_outlined, 'My Orders',
                  onTap: () => _push(const OrdersPage())),
              _item(Icons.credit_card_outlined, 'Payment Methods',
                  onTap: () => _push(const PaymentPage())),
            ]),
            _buildSection('PREFERENCES', [
              _item(Icons.notifications_outlined, 'Notifications',
                  onTap: () => _push(const NotificationsPage())),
              _item(Icons.lock_outline, 'Privacy & Security',
                  onTap: () => _push(const PrivacyPage())),
            ]),
            _buildSection('SUPPORT', [
              _item(Icons.help_outline, 'Help Center'),
              _item(Icons.info_outline, 'About Tawseel'),
            ]),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _onLogout,
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('Log Out',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Colors.red),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final String spendingText =
        '\$${(totalSpending / 1000).toStringAsFixed(1)}K';

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1A73E8),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.showBackButton)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 20),
                    )
                  else
                    const SizedBox(width: 20),
                  const Text(
                    'My Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 22),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white24,
                    child:
                        Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt,
                          size: 14, color: Color(0xFF1A73E8)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                userName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                phone,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 13),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '⭐ Gold Member',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _stat(points.toString(), 'Points'),
                  Container(width: 1, height: 40, color: Colors.white24),
                  _stat(spendingText, 'Spending'),
                  Container(width: 1, height: 40, color: Colors.white24),
                  _stat(totalOrders.toString(), 'Orders'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
                fontSize: 11, color: Colors.white.withOpacity(0.8))),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.5)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
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
            children: List.generate(items.length, (i) {
              return Column(
                children: [
                  items[i],
                  if (i < items.length - 1)
                    Divider(
                        height: 1, indent: 64, color: Colors.grey.shade100),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _item(IconData icon, String label, {VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
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
      trailing: const Icon(Icons.arrow_forward_ios,
          size: 14, color: Colors.grey),
    );
  }
}
