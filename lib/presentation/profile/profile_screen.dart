import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../user/login/login_screen.dart';
import 'profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getUser();
    });
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Are you sure you want to log out from this app?',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                        viewModel.logout();
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('User Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
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
      body:Consumer<ProfileViewModel>(
        builder: (context, viewModel, _) {
        
          if (viewModel.isLoadingUser) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // if (viewModel.user == null) {
          //   return const Center(
          //     child: Text('No user data available'),
          //   );
          // }
          return Column(
        children: [
          // Profile Image and Username Section
          Container(
            padding: const EdgeInsets.all(20.0),
            child:  Column(
              children: [
                const CircleAvatar(
                  radius: 50.0,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ), // Replace with your profile image
                ),
                const SizedBox(height: 10.0),
                 Text(
                  viewModel.user?.name ?? '', // Replace with the username
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  viewModel.user?.email ?? '', // Replace with user email or description
                  style: const TextStyle(
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
                // _buildMenuItem(
                //   context,
                //   icon: Icons.shopping_bag,
                //   title: 'Order Details',
                //   onTap: () {
                //     // Navigate to Order Details Page
                //     print('Order Details clicked');
                //   },
                // ),
                // _buildMenuItem(
                //   context,
                //   icon: Icons.miscellaneous_services,
                //   title: 'Service',
                //   onTap: () {
                //     // Navigate to Services Page
                //     print('Service clicked');
                //   },
                // ),
              ],
            ),
          ),

          const Divider(height: 1.0, thickness: 1.0),

          // Logout Button at the Bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Transparent background
                shadowColor: Colors.transparent, // Remove shadow
                padding: EdgeInsets.zero, // No padding to fit the gradient
              ),
              onPressed: _handleLogout,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
      );
  }));
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
