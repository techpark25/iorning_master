import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/my_textfield.dart';
import '../../../utils/api_status.dart';
import '../../main/main_screen.dart';
import '../register/signup_screen.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();

  late LoginViewModel viewModel;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _validateFields() {
    if (emailController.text.isEmpty) {
      _showSnackbar('Please enter your email address');
      return false;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      _showSnackbar('Please enter a valid email address');
      return false;
    }

    if (passwordController.text.isEmpty) {
      _showSnackbar('Please enter your password');
      return false;
    }

    // Uncomment if type is mandatory
    // if (_selectedTypes.isEmpty) {
    //   _showSnackbar('Please select at least one type');
    //   return false;
    // }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Consumer<LoginViewModel>(builder: (context, viewModel, child) {
        if (viewModel.data != null && viewModel.data?.code == 200) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
              viewModel.reset();
            },
          );
        }   if (viewModel.loginResponse.status == ApiStatus.error) {
            Future.microtask(() {
              _showSnackbar(viewModel.errorMessage ?? 'An unexpected error occurred.');
              viewModel.reset();
            });
          }
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/img/login-bg.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.26),
                    const Text("Log in",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ClipRect(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(_opacity),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Form(
                            key: _formKey,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyTextField(
                                    controller: emailController,
                                    hintText: 'Enter Username',
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  MyPasswordTextField(
                                    controller: passwordController,
                                    hintText: 'Enter Password',
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  // Gradient Button
                                  GestureDetector(
                                    onTap: viewModel.loginResponse.status ==
                                            ApiStatus.loading
                                        ? null
                                        : () {
                                            if (_validateFields()) {
                                              viewModel.login(
                                                emailController.text,
                                                passwordController.text,
                                              );
                                            }
                                          },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFDC846), // Golden Yellow
                                            Color(0xFFD32943), // Red
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white, // Text color
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),

                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to Signup page when clicked
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen()), // Navigate to Signup page
                                      );
                                    },
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                   GestureDetector(
                                    onTap: () {
                                      // Navigate to Signup page when clicked
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen()), // Navigate to Signup page
                                      );
                                    },
                                    child: const Text(
                                      "Don't have a account register here !",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
