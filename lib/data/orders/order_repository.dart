import 'package:dio/dio.dart';

import 'model/order_create_response.dart';
import 'model/order_detail_response.dart';
import 'model/order_list_response.dart';
import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';
import 'model/order.dart';

class OrderRepository {
  Future<ApiResponse<List<Order>>> getOrders() async {
    try {
      String url = '/orders';

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final ordersResponse = OrderListResponse.fromJson(response.data);
      return ApiResponse.success(ordersResponse.data);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }

  Future<ApiResponse<OrderDetailResponse>> getOrderDetail(
    int? orderId,
  ) async {
    try {
      String url = '/order/detail/$orderId';

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final orderDetailResponse = OrderDetailResponse.fromJson(response.data);
      return ApiResponse.success(orderDetailResponse);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }

  Future<ApiResponse<OrderCreateResponse?>> createOrder(
     { String? pickupLocation,
      String? paymentMode,
      List<Map<String, dynamic>>? products,
      String? timeSlot,
      String? pickupDate}) async {
    final reqData = {
      "pickup_location": pickupLocation,
      "payment_mode": paymentMode,
      "products": products,
      "time_slot": timeSlot,
      "pickup_date": pickupDate,
    };

    try {
      final dio = await DioWrapper().getDio();
      Response response = await dio.post('/order/create', data: reqData);
      final registerResponse = OrderCreateResponse.fromJson(response.data);

      return ApiResponse.success(registerResponse);
    } on DioException catch (e) {
      return ApiResponse.error(e, "Failed to create order");
    }
  }
  
}
