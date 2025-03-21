import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'model/logout_response.dart';
import 'model/register_response.dart';
import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';
import 'model/login_response.dart';
import 'model/user.dart';

class UserRepository {
  final String _prefKeyToken = "api-access-token";
  final _prefKeyProfile = "user-profile";

  Future<ApiResponse<RegisterResponse?>> register(
      String name, String email, String password) async {
    final reqData = {'email': email, 'password': password, 'name': name};
    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.post('/signup', data: reqData);
      final registerResponse = RegisterResponse.fromJson(response.data);
      print("Register response: ${response.data}");

      if (registerResponse.data?.token != null) {
        await saveApiAccessToken(registerResponse.data!.token!);
        if (registerResponse.data?.user != null) {
          await saveUserProfile(registerResponse.data!.user!);
        } else {
          return ApiResponse.error(
            null,
            registerResponse.message ?? 'Failed to save user profile.',
          );
        }
        return ApiResponse.success(registerResponse);
      } else {
        return ApiResponse.error(
          null,
          registerResponse.message ?? 'Token is missing. Please try again.',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }

  Future<ApiResponse<LoginResponse?>> login(
      String email, String password) async {
    final reqData = {'email': email, 'password': password};
    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.post('/login', data: reqData);
      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);
        print("Login response: ${response.data}");

        if (loginResponse.token != null && loginResponse.user != null) {
          print("User data before saving: ${loginResponse.user?.toJson()}");
          await saveApiAccessToken(loginResponse.token!);
          await saveUserProfile(loginResponse.user!); // Save user profile here
          return ApiResponse.success(loginResponse);
        } else {
          return ApiResponse.error(
            null,
            loginResponse.message ?? 'Login failed. Please try again.',
          );
        }
      } else {
        return ApiResponse.error(
          null,
          'Login failed, Server error ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(e, "Invalid credentials. Please try again.");
    }
  }

  Future<ApiResponse<User?>> getProfile() async {
    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.get('/profile');
      print("Profile API response: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        final profileResponse = User.fromJson(response.data);
        await saveUserProfile(profileResponse); // Persist user profile
        return ApiResponse.success(profileResponse);
      } else {
        return ApiResponse.error(null, "No data received from server");
      }
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    } catch (e) {
      return ApiResponse.error(Exception(e), '');
    }
  }

  Future<User?> getUserProfile() async {
    final preferences = await SharedPreferences.getInstance();
    final userJson = preferences.getString(_prefKeyProfile);
    print("Fetched user JSON: $userJson");

    if (userJson != null && userJson.isNotEmpty) {
      try {
        final userMap = jsonDecode(userJson);
        print("Decoded user map: $userMap");
        if (userMap is Map<String, dynamic>) {
          return User.fromJson(userMap);
        } else {
          print("Error: userMap is not a Map<String, dynamic>");
        }
      } catch (e) {
        print("Error decoding user JSON: $e");
      }
    }
    return null;
  }

  Future<String?> getApiAccessToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_prefKeyToken);
  }

  Future<void> saveUserProfile(User user) async {
    final preferences = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    print("Saving user profile: $userJson"); // Log saved data
    await preferences.setString(_prefKeyProfile, userJson);

    // Verify if data is saved correctly
    final savedUserJson = preferences.getString(_prefKeyProfile);
    print("User profile saved: $savedUserJson");
  }

  Future<void> saveApiAccessToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    print("Saving API access token: $token"); // Log saved token
    await preferences.setString(_prefKeyToken, token);

    // Verify if token is saved correctly
    final savedToken = preferences.getString(_prefKeyToken);
    print("API token saved: $savedToken");
  }

  Future<ApiResponse<LogoutResponse?>> logout() async {
    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.post('/logout');
      print("Logout response: ${response.data}");

      final logoutResponse = LogoutResponse.fromJson(response.data);

      // Clear SharedPreferences
      final preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      print("Preferences cleared");

      return ApiResponse.success(logoutResponse);
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to log out: ${e.message}");
    } catch (e) {
      return ApiResponse.error(Exception(e), "An unexpected error occurred");
    }
  }
}
