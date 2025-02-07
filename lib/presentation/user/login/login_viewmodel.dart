import 'package:flutter/cupertino.dart';
import '../../../data/user/model/login_response.dart';
import '../../../utils/api_status.dart';
import '../../../data/user/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository repository = UserRepository();

  ApiResponse<LoginResponse?> loginResponse = ApiResponse.idle();
  String? errorMessage;
  LoginResponse? data;

  void reset() {
    loginResponse = ApiResponse.idle();
    data = null;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    loginResponse = ApiResponse.loading('Loading...');
    notifyListeners();

    final response = await repository.login(email, password);

    if (response.status == ApiStatus.success) {
      data = response.data;
      notifyListeners();
    } else if (response.status == ApiStatus.error) {
      errorMessage = response.message ?? 'An unexpected error occurred.';
      loginResponse = ApiResponse.error(response.exception, errorMessage);
      notifyListeners();
    }
  }
}
