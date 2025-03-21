import 'package:dio/dio.dart';


import '../../utils/api_status.dart';
import '../../utils/dio_wrapper.dart';
import 'model/notification.dart';
import 'model/notification_detail_response.dart';
import 'model/notification_list_response.dart';

class NotificationRepository {
  Future<ApiResponse<List<Notification>>> getNotifications() async {
    try {
      String url = '/notifications';

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final ordersResponse = NotificationListResponse.fromJson(response.data);
      return ApiResponse.success(ordersResponse.data);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }

  Future<ApiResponse<NotificationDetailResponse>> getNotificationDetail(
    int? notificationId,
  ) async {
    try {
      String url = '/notifications/$notificationId';

      final dio = await DioWrapper().getDio();
      Response response = await dio.get(url);
      final orderDetailResponse = NotificationDetailResponse.fromJson(response.data);
      return ApiResponse.success(orderDetailResponse);
    } on DioError catch (e) {
      return ApiResponse.error(e, "Failed to get data");
    }
  }
  }