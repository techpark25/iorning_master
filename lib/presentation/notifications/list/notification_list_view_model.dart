import 'package:flutter/material.dart';


import '../../../data/notification/notification_repository.dart';
import '../../../utils/api_status.dart';
import '../../../data/notification/model/notification.dart' as no;

class  NotificationListViewModel extends ChangeNotifier {
  final NotificationRepository repository = NotificationRepository();

  ApiResponse<List<no.Notification>> _categoriesResponse = ApiResponse.idle();
  bool _showOrders = false;
  bool _lodingOrders = false;
  List<no.Notification> _notifications= [];

  bool get showOrders => _showOrders;
  bool get loadingOrders => _lodingOrders;
  List<no.Notification> get notifications => _notifications;


  

  Future getNotifications() async {
    // if (_carouselImagesResponse.status == ApiStatus.success) return;

    _notifyCategoriesLoading();
    _categoriesResponse = await repository.getNotifications();
    _notifyCategoriesResponse();
  }

  void _notifyCategoriesLoading() {
    _categoriesResponse = ApiResponse.loading('');
    _showOrders = true;
    _lodingOrders = true;
    notifyListeners();
  }

  void _notifyCategoriesResponse() {
    _lodingOrders = false;
    if (_categoriesResponse.status == ApiStatus.success) {
      final notifications = _categoriesResponse.data;
      if (_categoriesResponse.status == ApiStatus.error ||
          notifications == null ||
          notifications.isEmpty) {
        _showOrders = false;
      } else {
        _notifications = notifications;
      }
    }
    notifyListeners();
  }
}