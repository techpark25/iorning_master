import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/my_textfield.dart';
import '../../../utils/api_status.dart';
import '../../main/main_screen.dart';
import 'register_view_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // text editing controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  late RegisterViewModel viewModel;

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
      body: Consumer<RegisterViewModel>(builder: (context, viewModel, child) {
        if (viewModel.data != null && viewModel.data?.code == 201) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainScreen()),
                (Route<dynamic> route) =>
                    false, // This condition removes all previous routes
              );
              viewModel.reset();
            },
          );
        } else if (viewModel.registerResponse.status == ApiStatus.error) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              _showSnackbar(viewModel.errorMessage ?? '');
              viewModel.reset();
            },
          );
        }
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/img/signup-bg.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.26),
                    const Text("Sign Up",
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(_opacity),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.49,
                          child: Form(
                            key: _formKey,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 10),

                                  const Text(
                                      "Look like you don't have an account. Let's create a new account for",
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      textAlign: TextAlign.start),
                                  // ignore: prefer_const_constructors
                                  Expanded(
                                    child: MyTextField(
                                      controller: nameController,
                                      hintText: 'Name',
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  Expanded(
                                    child: MyTextField(
                                      controller: emailController,
                                      hintText: 'Email',
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  MyPasswordTextField(
                                    controller: passwordController,
                                    hintText: 'Password',
                                  ),
                                  const SizedBox(height: 30),

                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          text: '',
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  'By selecting Agree & Continue below, I agree to our ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            TextSpan(
                                                text:
                                                    'Terms of Service and Privacy Policy',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 71, 233, 133),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Gradient Button
                                      GestureDetector(
                                        onTap: viewModel
                                                    .registerResponse.status ==
                                                ApiStatus.loading
                                            ? null
                                            : () {
                                                if (_validateFields()) {
                                                  viewModel.register(
                                                      nameController.text,
                                                      emailController.text,
                                                      passwordController.text);
                                                }
                                              },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(
                                                    0xFFFDC846), // Golden Yellow
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
                                            "Signup",
                                            style: TextStyle(
                                              color: Colors.white, // Text color
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
