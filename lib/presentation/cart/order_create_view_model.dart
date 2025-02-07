import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/orders/model/order_create_response.dart';
import '../../data/orders/order_repository.dart';
import '../../utils/api_status.dart';

class OrderCreateViewModel extends ChangeNotifier {
  final OrderRepository repository = OrderRepository();

  ApiResponse<OrderCreateResponse?> orderResponse = ApiResponse.idle();
  String errorMessage = "";

  OrderCreateResponse? data;

  void reset() {
    orderResponse = ApiResponse.idle();
    data = null;
    errorMessage = "";
    notifyListeners();
  }

  Future<void> createOrder({
    required String pickupLocation,
    required String paymentMode,
    required List<Map<String, dynamic>> products,
    required String timeSlot,
    required String pickupDate,
  }) async {
    orderResponse = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      orderResponse = await repository.createOrder(
        pickupLocation: pickupLocation,
        paymentMode: paymentMode,
        products: products,
        timeSlot: timeSlot,
        pickupDate: pickupDate,
      );

      if (orderResponse.status == ApiStatus.success) {
        data = orderResponse.data;
      } else if (orderResponse.status == ApiStatus.error) {
        final e = orderResponse.exception;
        if (e is DioException) {
          if (e.response?.statusCode == 400) {
            errorMessage = "Invalid order details. Please check and try again.";
          } else if (e.response?.statusCode == 404) {
            errorMessage = "Requested resource not found.";
          } else {
            errorMessage = "An unexpected error occurred. Please try again.";
          }
        } else {
          errorMessage = "An unexpected error occurred. Please try again.";
        }
      }
    } catch (e) {
      errorMessage = "An unexpected error occurred. Please try again.";
    } finally {
      notifyListeners();
    }
  }
}
