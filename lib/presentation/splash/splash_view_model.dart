import 'package:flutter/material.dart';

import '../../../navigation/routes.dart';
import '../../../utils/api_status.dart';
import '../../../data/user/model/user.dart';
import '../../../data/user/user_repository.dart';

class SplashViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user;
  User? get user => _user;

  String? _redirectTo;
  String? get redirectTo => _redirectTo;

  Future getUser() async {
    _isLoading = true;
    notifyListeners();

    _user = await userRepository.getUserProfile();

    if (_user == null) {
      // If user is not retrieved, wait and redirect to login
      await Future.delayed(const Duration(seconds: 3));
      _setDestination(userLoginRoute);
    } else {
      await getAccount();
    }
  }

  Future getAccount() async {
    final profileResponse = await userRepository.getProfile();
    
    if (profileResponse.status == ApiStatus.success && profileResponse.data != null) {
      userRepository.saveUserProfile(profileResponse.data!);
      _setDestination(mainRoute);
    } else {
      // If there's an error or the data is not valid, wait and redirect to login
      await Future.delayed(const Duration(seconds: 3));
      _setDestination(userLoginRoute);
    }
  }

  void _setDestination(String route) {
    debugPrint('########## viewModel _setDestination start');
    _redirectTo = route;
    debugPrint('########## viewModel _setDestination ${route}');

    notifyListeners();
    debugPrint('########## viewModel _setDestination end');
  }
}
