import 'package:flutter/material.dart';
import 'package:laundry_application/themes.dart';
import 'package:provider/provider.dart';
import '../../SplashScreen2.dart';
import 'splash_view_model.dart'; // Import the second splash screen.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<SplashViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.getUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.primaryColor, // Customize the background color
      body: Consumer<SplashViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.redirectTo != null) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  viewModel.redirectTo!,
                  (route) => false,
                );
              },
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/ironing-master-new-logo.png",
                    width: 100, height: 100), // Add your logo
                const SizedBox(height: 20),
                // const Text(
                //   'Ironing Master',
                //   style: TextStyle(
                //     fontSize: 24,
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
