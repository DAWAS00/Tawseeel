import 'package:flutter/material.dart';
import 'home_controller.dart';
import 'widgets/home_bottom_nav.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/category_filter.dart';
import 'widgets/near_you_section.dart';
import 'widgets/recently_added_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const HomeDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeHeader(),
                    const HomeSearchBar(),
                    CategoryFilter(
                      categories: _controller.categories,
                      selectedIndex: _controller.selectedCategory,
                      onCategorySelected: (index) => setState(() => _controller.selectedCategory = index),
                    ),
                    NearYouSection(vendors: _controller.nearYouVendors),
                    RecentlyAddedSection(
                      vendors: _controller.recentlyAdded,
                      onVendorTap: (vendor) => _controller.goToVendor(context, vendor.name),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _controller.selectedNavIndex,
        onTap: (index) => setState(() => _controller.selectedNavIndex = index),
      ),
    );
  }
}
