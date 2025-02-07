import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../utils/api_status.dart';
import '../../data/address/address_repository.dart';
import '../../data/address/data/address.dart';
import '../../data/address/data/address_create_response.dart';
import '../../data/address/data/address_status_response.dart';

class AddressViewModel extends ChangeNotifier {
  final AddressRepository repository = AddressRepository();

  ApiResponse<List<Address>> _addressResponse = ApiResponse.idle();
  ApiResponse<AddressCreateResponse?> addresscreateResponse =
      ApiResponse.idle();
  ApiResponse<AddressStatusResponse?> addressStatusResponse =
      ApiResponse.idle();

  bool _showAddress = false;
  bool _loadingAddress = false;
    bool _isloadingAddress = false;

  List<Address> _address = [];

  bool get showAddress => _showAddress;
  bool get loadingAddress => _loadingAddress;
    bool get isloadingAddress => _isloadingAddress;

  List<Address> get address => _address;

  String errorMessage = "";
  int? loadingAddressId; // Track which address is loading

  AddressCreateResponse? data;
  AddressStatusResponse? status;

  void reset() {
    addresscreateResponse = ApiResponse.idle();
    data = null;
    status = null;
    errorMessage = "";
    notifyListeners();
  }

  Future getAddress() async {
    // if (_carouselImagesResponse.status == ApiStatus.success) return;

    _notifyAddressLoading();
    _addressResponse = await repository.getAddress();
    _notifyAddressResponse();
  }

   Future getActiveAddress() async {
    // if (_carouselImagesResponse.status == ApiStatus.success) return;

    _notifyAddressLoading();
    _addressResponse = await repository.getAddress();
    _notifyActiveAddressResponse();
  }

  void _notifyAddressLoading() {
    _addressResponse = ApiResponse.loading('');
    _showAddress = true;
    _loadingAddress = true;
    notifyListeners();
  }

  void _notifyAddressResponse() {
    _loadingAddress = false;
    if (_addressResponse.status == ApiStatus.success) {
      final address = _addressResponse.data;
      if (_addressResponse.status == ApiStatus.error ||
          address == null ||
          address.isEmpty) {
        _showAddress = false;
      } else {
        _address = address;
        // _filterActiveAddress();
      }
    }
    notifyListeners();
  }
   void _notifyActiveAddressResponse() {
    _loadingAddress = false;
    if (_addressResponse.status == ApiStatus.success) {
      final address = _addressResponse.data;
      if (_addressResponse.status == ApiStatus.error ||
          address == null ||
          address.isEmpty) {
        _showAddress = false;
      } else {
        _address = address;
        _filterActiveAddress();
      }
    }
    notifyListeners();
  }
 void _filterActiveAddress() {
    _address = _address.where((address) => address.activeStatus == 1).toList();
    if (_address.isNotEmpty) {
      _showAddress = true;  // Show address if there are any active addresses
    } else {
      _showAddress = false; // Hide address if no active address found
    }
    notifyListeners();
  }
  Future<void> createAddress(
      {required String name,
      required String houseNo,
      required String addressLine1,
      required String addressLine2,
      required String landmark,
      required String pincode,
      required String latitude,
      required String longitude,
      required bool status}) async {
    addresscreateResponse = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      addresscreateResponse = await repository.createAddress(
          name: name,
          houseNo: houseNo,
          addressLine1: addressLine1,
          addressLine2: addressLine2,
          landmark: landmark,
          pincode: pincode,
          latitude: latitude,
          longitude: longitude,
          status: status);

      if (addresscreateResponse.status == ApiStatus.success) {
        data = addresscreateResponse.data;
      } else if (addresscreateResponse.status == ApiStatus.error) {
        final e = addresscreateResponse.exception;
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

 Future<void> updateStatus(int addressId) async {
  _isloadingAddress = true;
  notifyListeners(); // Notify listeners that loading has started

  try {
    addressStatusResponse = await repository.updateStatus(addressId);

    if (addressStatusResponse.status == ApiStatus.success) {
      final addressIndex = address.indexWhere((addr) => addr.id == addressId);
      if (addressIndex != -1) {
        // Reset all addresses' activeStatus before selecting the new one
        for (var addr in address) {
          addr.updateActiveStatus(0);
        }

        // Update the selected address
        address[addressIndex].updateActiveStatus(1);
        
        // Now repull the addresses after status update
        await getAddress();  // This should repull the addresses after the status change
      }
    }
  } catch (e) {
    errorMessage = "An unexpected error occurred. Please try again.";
  } finally {
    _isloadingAddress = false;
    notifyListeners(); // Notify after completing the process
  }
}




void handleErrorResponse(Exception exception) {
  if (exception is DioException) {
    if (exception.response?.statusCode == 400) {
      errorMessage = "Invalid order details. Please check and try again.";
    } else if (exception.response?.statusCode == 404) {
      errorMessage = "Requested resource not found.";
    }
  } else {
    errorMessage = "An unexpected error occurred. Please try again.";
  }
}

int? updatingAddressId;

void setUpdatingAddressId(int? id) {
  updatingAddressId = id;
  notifyListeners();
}


}
