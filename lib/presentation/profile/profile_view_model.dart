import 'package:flutter/material.dart';
import '../../data/user/user_repository.dart';
import '../../data/user/model/user.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  bool _isLoadingUser = false;
  bool get isLoadingUser => _isLoadingUser;

  User? _user;
  User? get user => _user;

  Future getUser() async {
    _isLoadingUser = true;
    notifyListeners();

    _user = await _userRepository.getUserProfile();

    _isLoadingUser = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _userRepository.logout();
    _user = null;
    notifyListeners();
  }
}
