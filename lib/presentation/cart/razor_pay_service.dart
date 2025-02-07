import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiServices {
  final String razorPayKey = dotenv.env['RZP_KEY'] ?? '';
final String razorPaySecret = dotenv.env['RZP_SECRET'] ?? '';


  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.razorpay.com/v1/',
    headers: {'Content-Type': 'application/json'},
  ));

  Future<Map<String, dynamic>> razorPayApi(num amount, String receiptId) async {
    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$razorPayKey:$razorPaySecret'))}';

      var response = await _dio.post(
        'orders',
        data: {
          "amount": amount * 100, // Amount in smallest unit (paise)
          "currency": "INR",
          "receipt": receiptId
        },
        options: Options(
          headers: {"Authorization": basicAuth},
        ),
      );

      return {
        "status": "success",
        "body": response.data,
      };
    } on DioException catch (e) {
      return {
        "status": "fail",
        "message": e.response?.statusMessage ?? "Something went wrong",
      };
    }
  }
}
