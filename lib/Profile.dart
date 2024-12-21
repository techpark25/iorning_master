import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('User Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFDC846), // Golden Yellow
                Color(0xFFD32943), // Red
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Profile Image and Username Section
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(
                      'assets/profile_image.png'), // Replace with your profile image
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'John Doe', // Replace with the username
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'johndoe@example.com', // Replace with user email or description
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1.0, thickness: 1.0),

          // Menu Options
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () {
                    // Navigate to Profile Page
                    print('Profile clicked');
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.shopping_bag,
                  title: 'Order Details',
                  onTap: () {
                    // Navigate to Order Details Page
                    print('Order Details clicked');
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.miscellaneous_services,
                  title: 'Service',
                  onTap: () {
                    // Navigate to Services Page
                    print('Service clicked');
                  },
                ),
              ],
            ),
          ),

          const Divider(height: 1.0, thickness: 1.0),

          // Logout Button at the Bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Transparent background
                shadowColor: Colors.transparent, // Remove shadow
                padding: EdgeInsets.zero, // No padding to fit the gradient
              ),
              onPressed: () {
                // Handle logout logic here
                print("Logout pressed");
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 228, 228, 228), // Red
                      Color.fromARGB(255, 228, 228, 228), // Golden Yellow
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0), // Text color for the button
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method to Create Menu Items
  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.red), // Customize the color
      title: Text(
        title,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
      onTap: onTap,
    );
  }
}
