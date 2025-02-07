import 'package:flutter/material.dart';

import '../../data/product/model/product.dart';
import '../../data/product/model/sub_category.dart';
import '../../data/product/model/product_list_response.dart';
import '../../data/product/product_repository.dart';
import '../../utils/api_status.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository productrepository = ProductRepository();

  ApiResponse<ProductByCategoryData> _itemsResponse = ApiResponse.idle();
//   ApiResponse<WishlistUpdateData?> _wishlistSelectResponse = ApiResponse.idle();

  bool _loadingItems = false;
  bool _loadingFailed = false;
  int _activeCategory = -1;
  List<Subcategory> _subcategories = [];
  List<Product> _products = [];

  bool get loadingItems => _loadingItems;
  bool get loadingFailed => _loadingFailed;
  int get activeCategory => _activeCategory;
  List<Subcategory> get subcategories => _subcategories;
  List<Product> get products => _products;

  void reset() {
    _loadingItems = false;
    _loadingFailed = false;
    _activeCategory = -1;
    _subcategories = [];
    _products = [];
  }

  Future getProducts(int? categoryId, int? subcategoryId) async {
  _notifyPopularCategoriesLoading();

  // If subcategoryId is null, set it to 0 for the "All" category
  if (subcategoryId == null || subcategoryId == 0) {
    subcategoryId = 0; // or null if you prefer
  }

  // Call the repository to fetch the products
  _itemsResponse = await productrepository.getProducts(categoryId, subcategoryId);

  _notifyPopularCategoriesResponse();
}


 void _notifyPopularCategoriesLoading() {
  _itemsResponse = ApiResponse.loading('');
  _loadingItems = true;
  _loadingFailed = false;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    notifyListeners(); // This ensures UI updates after build phase
  });
}


//   void updateWishlist(int itemId, int wishlist) async {
//     _wishlistSelectResponse =
//         await servicerepository.updateWishlist(itemId, wishlist);
//     if (_wishlistSelectResponse.status == ApiStatus.success) {
//       _services = _services
//           .map((e) => e.id == itemId
//               ? e.copyWith(wishlist: _wishlistSelectResponse.data?.wishlist)
//               : e)
//           .toList();
//     } else {}
//     notifyListeners();
//   }

  void _notifyPopularCategoriesResponse() {
    _loadingItems = false;

    if (_itemsResponse.status == ApiStatus.success) {
       _activeCategory = _itemsResponse.data?.activeCategory ?? -1;
      _subcategories = _itemsResponse.data?.subcategories ?? [];
      _products = _itemsResponse.data?.products ?? [];
    } else if (_itemsResponse.status == ApiStatus.error) {
      _loadingFailed = true;
    }

    notifyListeners();
  }


}
