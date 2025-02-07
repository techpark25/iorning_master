import 'package:flutter/cupertino.dart';


import '../../data/carousel/carousel_list_response.dart';
import '../../data/carousel/carousel_repository.dart';
import '../../data/category/category_repository.dart';
import '../../data/category/model/category.dart';
import '../../data/user/model/user.dart';
import '../../data/user/user_repository.dart';
import '../../utils/api_status.dart';

class HomeViewModel extends ChangeNotifier {
  final CategoryRepository repository = CategoryRepository();
  final CarouselRepository carouselRepository = CarouselRepository();
    final UserRepository _userRepository = UserRepository();

  ApiResponse<List<Carousel>> _carouselImagesResponse = ApiResponse.idle();
  bool _showCarouselImages = false;
  bool _loadingCarouselImages = false;
  List<Carousel> _carouselImages = [];

  bool get showCarouselImages => _showCarouselImages;
  bool get loadingCarouselImages => _loadingCarouselImages;
  List<Carousel> get carouselImages => _carouselImages;
  ApiResponse<List<Category>> _categoriesResponse = ApiResponse.idle();
  bool _showCategories = false;
  bool _loadingCategories = false;
  List<Category> _categories = [];

  bool get showCategories => _showCategories;
  bool get loadingCategories => _loadingCategories;
  List<Category> get categories => _categories;

  bool _isLoadingUser = false;
  bool get isLoadingUser => _isLoadingUser;

  User? _user;
  User? get user => _user;


  Future getCarouselImages() async {
    // if (_carouselImagesResponse.status == ApiStatus.success) return;

    _notifyCarouselImagesLoading();
    _carouselImagesResponse = await carouselRepository.getImage();
    _notifyCarouselImagesResponse();
  }

  void _notifyCarouselImagesLoading() {
    _carouselImagesResponse = ApiResponse.loading('');
    _showCarouselImages = true;
    _loadingCarouselImages = true;
    notifyListeners();
  }

  void _notifyCarouselImagesResponse() {
    _loadingCarouselImages = false;
    if (_carouselImagesResponse.status == ApiStatus.success) {
      final carouselImages = _carouselImagesResponse.data;
      if (_carouselImagesResponse.status == ApiStatus.error ||
          carouselImages == null ||
          carouselImages.isEmpty) {
        _showCarouselImages = false;
      } else {
        _carouselImages = carouselImages;
      }
    }
    notifyListeners();
  }
  Future<void> getUser() async {
    _isLoadingUser = true;
    notifyListeners();

    try {
      final user = await _userRepository.getUserProfile();
     
      if (user != null) {
        _user = user;
      } else {
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }

    _isLoadingUser = false;
    notifyListeners();
  }

  Future getCategories() async {
    // if (_carouselImagesResponse.status == ApiStatus.success) return;

    _notifyCategoriesLoading();
    _categoriesResponse = await repository.getCategories();
    _notifyCategoriesResponse();
  }

  void _notifyCategoriesLoading() {
    _categoriesResponse = ApiResponse.loading('');
    _showCategories = true;
    _loadingCategories = true;
    notifyListeners();
  }

  void _notifyCategoriesResponse() {
    _loadingCategories = false;
    if (_categoriesResponse.status == ApiStatus.success) {
      final categories = _categoriesResponse.data;
      if (_categoriesResponse.status == ApiStatus.error ||
          categories == null ||
          categories.isEmpty) {
        _showCategories = false;
      } else {
        _categories = categories;
      }
    }
    notifyListeners();
  }
}