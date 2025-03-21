import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:laundry_application/themes.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../../Schedule.dart';
import '../orders/list/order_list_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    const HomeScreen(),
    CartScreen(),
    const OrderListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      // Wrap the CurvedNavigationBar with a Container to show gradient
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppThemes.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          color: Colors.transparent, // Transparent to show gradient
          backgroundColor: Colors.transparent, // Set background to transparent
          buttonBackgroundColor: Colors.white,
          height: 60,
          items: <Widget>[
            _buildIcon(Icons.home, 0),
            _buildIcon(Icons.shopping_basket, 1),
            _buildIcon(Icons.delivery_dining, 2),
            _buildIcon(Icons.person, 3),
          ],
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          animationDuration: const Duration(milliseconds: 300),
        ),
      ),
      body: Column(
        children: [
          // Header Section

          // Page Content
          Expanded(
            child: _pages[_pageIndex],
          ),
        ],
      ),
    );
  }

  // Helper function to build the icon with dynamic background shadow and padding
  Widget _buildIcon(IconData icon, int index) {
    return Container(
      padding: _pageIndex == index
          ? const EdgeInsets.all(10) // Add padding for active icon
          : EdgeInsets.zero, // No padding for non-active
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: _pageIndex == index
            ? AppThemes.primaryColor // Active background color
            : Colors.transparent, // Transparent for non-active
      ),
      child: Center(
        child: Icon(
          icon,
          size: _pageIndex == index ? 28 : 30, // Adjust size for active state
          color: _pageIndex == index
              ? AppThemes.backgroundColor // Icon color for active
              : AppThemes.backgroundColor, // Icon color for non-active
        ),
      ),
    );
  }
}
