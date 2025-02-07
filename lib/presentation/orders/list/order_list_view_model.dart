import 'package:flutter/material.dart';

import '../../../data/orders/model/order.dart';
import '../../../data/orders/order_repository.dart';
import '../../../utils/api_status.dart';

class  OrderListViewModel extends ChangeNotifier {
  final OrderRepository repository = OrderRepository();

  ApiResponse<List<Order>> _categoriesResponse = ApiResponse.idle();
  bool _showOrders = false;
  bool _lodingOrders = false;
  List<Order> _orders = [];

  bool get showOrders => _showOrders;
  bool get loadingOrders => _lodingOrders;
  List<Order> get orders => _orders;


  

  Future getOrders() async {
    // if (_carouselImagesResponse.status == ApiStatus.success) return;

    _notifyCategoriesLoading();
    _categoriesResponse = await repository.getOrders();
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
      final orders = _categoriesResponse.data;
      if (_categoriesResponse.status == ApiStatus.error ||
          orders == null ||
          orders.isEmpty) {
        _showOrders = false;
      } else {
        _orders = orders;
      }
    }
    notifyListeners();
  }
}