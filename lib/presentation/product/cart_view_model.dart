import 'package:flutter/material.dart';

import '../../data/cart/model/cart_list_response.dart';
import '../../data/cart/cart_repository.dart';
import '../../data/cart/model/cart_remove_response.dart';
import '../../utils/api_status.dart';

class CartViewModel extends ChangeNotifier {
  final CartRepository _cartRepository = CartRepository();

  ApiResponse<CartListResponse> _cartResponse = ApiResponse.idle();
  ApiResponse<CartRemoveResponse> _clearCartResponse = ApiResponse.idle();

  bool _loadingCart = false;
  bool _loadingFailed = false;

  ApiResponse<CartListResponse> get cartResponse => _cartResponse;
  ApiResponse<CartRemoveResponse> get clearCartResponse => _clearCartResponse;

  bool get loadingCart => _loadingCart;
  bool get loadingFailed => _loadingFailed;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  CartListResponse get cartList =>
      _cartResponse.data ??
      CartListResponse(data: [], totalPrice: 0, totalQuantity: 0);

  // int? get totalPrice => cartList.totalPrice;
  // int? get totalQuantity => cartList.totalQuantity;

  List<Cart> _cartItems = [];
  List<Cart> get cartItems => _cartItems;

  double get totalPrice => _cartItems.fold(0.0, (sum, item) {
        double price =
            double.tryParse(item.product?.price?.toString() ?? '0.0') ?? 0.0;
        int quantity = item.quantity ?? 0;
        return sum + (price * quantity);
      });

  int get totalQuantity =>
      _cartItems.fold(0, (sum, item) => sum + (item.quantity ?? 0));

  void reset() {
    _cartResponse = ApiResponse.idle();
    _loadingCart = false;
    _loadingFailed = false;
    notifyListeners();
  }

  Future<void> getCart() async {
    _loadingCart = true;
    notifyListeners();

    final response = await _cartRepository.getCart();

    if (response.status == ApiStatus.success) {
      _cartItems = response.data!.data;
    } else {
      _errorMessage = response.message ?? 'Unknown error';
    }

    _loadingCart = false;
    notifyListeners();
  }



  Future<void> addToCart(int productId) async {
  _loadingCart = true;
  notifyListeners();

  final response = await _cartRepository.addToCart(productId);

  if (response.status == ApiStatus.success) {
    await getCart(); // Refetch the cart after adding an item
  } else {
    debugPrint("Error: ${response.message}");
  }

  _loadingCart = false;
  notifyListeners();
}

Future<void> removeFromCart(int cartItemId) async {
  _loadingCart = true;
  notifyListeners();

  final response = await _cartRepository.removeFromCart(cartItemId);

  if (response.status == ApiStatus.success) {
    await getCart(); // Refetch the cart after removing an item
  } else {
    debugPrint("Error: ${response.message}");
  }

  _loadingCart = false;
  notifyListeners();
}


  Future<void> clearCart() async {
    try {
      // Call the API to clear the cart
      final response = await _cartRepository.clearCart();

      // Set the response and notify listeners
      _clearCartResponse = response;
      notifyListeners();

      if (response.status != ApiStatus.success) {
        // Display error if cart clearing fails
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(response.message ?? "Failed to clear the cart")),
        // );
      }
    } catch (e) {
      // Handle error
      // _clearCartResponse = ApiResponse.error(e, "Failed to clear the cart");
      notifyListeners();
    }
  }
  // Future<void> updateProductQuantity(int productId, int newQuantity) async {
  //   final cart = cartList.data.firstWhere(
  //     (cart) => cart.productId == productId,
  //     orElse: () => Cart(
  //       id: null,
  //       userId: null,
  //       productId: productId,
  //       quantity: 0,
  //       createdAt: null,
  //       updatedAt: null,
  //       product: null,
  //     ),
  //   );

  //   if (newQuantity == 0) {
  //     if (cart.id != null) {
  //       await removeProductFromCart(cart.id!);
  //     }
  //   } else {
  //     // Optionally implement API update logic if required
  //     cart.quantity = newQuantity;
  //     notifyListeners();
  //   }
  // }

  // void _setLoadingState() {
  //   _cartResponse = ApiResponse.loading('');
  //   _loadingCart = true;
  //   _loadingFailed = false;
  //   notifyListeners();
  // }

  // void _setResponseState() {
  //   _loadingCart = false;
  //   if (_cartResponse.status == ApiStatus.success) {
  //     // Cart fetched successfully
  //   } else if (_cartResponse.status == ApiStatus.error) {
  //     _loadingFailed = true;
  //   }
  //   notifyListeners();
  // }
}
