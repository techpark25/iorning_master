import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/user/model/register_response.dart';
import '../../../utils/api_status.dart';
import '../../../data/user/user_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final UserRepository repository = UserRepository();

  ApiResponse<RegisterResponse?> registerResponse = ApiResponse.idle();
  String errorMessage = "";

  RegisterResponse? data;

  void reset() {
    registerResponse = ApiResponse.idle();
    data = null;
    errorMessage = "";
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
  registerResponse = ApiResponse.loading('Loading');
  notifyListeners();

  registerResponse = await repository.register(name, email, password);

  if (registerResponse.status == ApiStatus.success) {
    data = registerResponse.data;
  } else if (registerResponse.status == ApiStatus.error) {
    final e = registerResponse.exception;
    errorMessage = registerResponse.message!;

    if (e is DioException) {
      // Check for response status code
      if (e.response?.statusCode == 401) {
        // Handle invalid credentials
        errorMessage = "Invalid email or password. Please try again.";
      } else if (e.response?.data['errors'] != null) {
        // Handle validation errors from API response
        final validationErrors = e.response?.data['errors'];
        if (validationErrors != null && validationErrors.containsKey('password')) {
          errorMessage = validationErrors['password']?.first ??
              'Please check the input fields and try again.';
        } else {
          errorMessage = e.response?.data['message'] ?? 'An error occurred.';
        }
      } else {
        // Handle other errors
        errorMessage = "Failed to get data";
      }
    }
  }
  notifyListeners();
}
}
