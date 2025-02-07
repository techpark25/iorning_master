import 'package:flutter/material.dart';
import 'package:laundry_application/data/orders/model/order_detail_response.dart';
import '../../../data/orders/order_repository.dart';
import '../../../utils/api_status.dart';

class OrderDetailViewModel extends ChangeNotifier {
  final OrderRepository productrepository = OrderRepository();

  ApiResponse<OrderDetailResponse> _itemsResponse = ApiResponse.idle();

  bool _loadingItems = false;
  bool _loadingFailed = false;
  OrderDetailResponse? _orderDetail;

  bool get loadingOrders => _loadingItems;
  bool get loadingFailed => _loadingFailed;
  OrderDetailResponse? get orderDetail => _orderDetail;

  void reset() {
    _loadingItems = false;
    _loadingFailed = false;
    _orderDetail = null;
  }

  Future<void> getOrderDetail(int? orderId) async {
    _notifyLoading();
    _itemsResponse = await productrepository.getOrderDetail(orderId);
    _notifyResponse();
  }

  void _notifyLoading() {
    _itemsResponse = ApiResponse.loading('');
    _loadingItems = true;
    _loadingFailed = false;
    notifyListeners();
  }

  void _notifyResponse() {
    _loadingItems = false;

    if (_itemsResponse.status == ApiStatus.success) {
      _orderDetail = _itemsResponse.data;
    } else if (_itemsResponse.status == ApiStatus.error) {
      _loadingFailed = true;
    }

    notifyListeners();
  }
}
