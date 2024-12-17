import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'home.dart';
import 'profile.dart';
import 'product.dart';
import 'Schedule.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    const HomePage(),
    const ProductsPage(),
    const ProfilePage(),
    const Schedule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      // Wrap the CurvedNavigationBar with a Container to show gradient
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDC846), // Golden Yellow
              Color(0xFFD32943), // Red
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
            _buildIcon(Icons.person, 2),
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
          Container(
            decoration: BoxDecoration(
              color:
                  Color.fromRGBO(242, 242, 242, 1), // Correct background color
            ),
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu_rounded,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () {
                    // Handle profile icon tap
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/img/profile-avatar.png', // Path to your image
                    width: 40, // Set width as needed
                    height: 40, // Set height as needed
                  ),
                  onPressed: () {
                    // Handle profile image tap
                  },
                ),
              ],
            ),
          ),

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
            ? const Color.fromARGB(255, 255, 145, 0) // Active background color
            : Colors.transparent, // Transparent for non-active
      ),
      child: Center(
        child: Icon(
          icon,
          size: _pageIndex == index ? 28 : 30, // Adjust size for active state
          color: _pageIndex == index
              ? const Color.fromARGB(
                  255, 255, 255, 255) // Icon color for active
              : Colors.white, // Icon color for non-active
        ),
      ),
    );
  }
}
