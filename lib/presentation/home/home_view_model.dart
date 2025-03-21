import 'package:flutter/cupertino.dart';

import '../../data/carousel/carousel_list_response.dart';
import '../../data/carousel/carousel_repository.dart';
import '../../data/category/category_repository.dart';
import '../../data/category/model/menu.dart';
import '../../data/user/model/user.dart';
import '../../data/user/user_repository.dart';
import '../../utils/api_status.dart';

class HomeViewModel extends ChangeNotifier {
  final CategoryRepository repository = CategoryRepository();
  final CarouselRepository carouselRepository = CarouselRepository();
  final UserRepository _userRepository = UserRepository();

  // Carousel Images
  ApiResponse<List<Carousel>> _carouselImagesResponse = ApiResponse.idle();
  bool _showCarouselImages = false;
  bool _loadingCarouselImages = false;
  List<Carousel> _carouselImages = [];

  bool get showCarouselImages => _showCarouselImages;
  bool get loadingCarouselImages => _loadingCarouselImages;
  List<Carousel> get carouselImages => _carouselImages;

  // Menus with Categories
  ApiResponse<List<Menu>> _menusResponse = ApiResponse.idle();
  bool _showMenus = false;
  bool _loadingMenus = false;
  List<Menu> _menus = [];

  bool get showMenus => _showMenus;
  bool get loadingMenus => _loadingMenus;
  List<Menu> get menus => _menus;

  // User
  bool _isLoadingUser = false;
  bool get isLoadingUser => _isLoadingUser;

  User? _user;
  User? get user => _user;

  Future getCarouselImages() async {
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
      if (carouselImages == null || carouselImages.isEmpty) {
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
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }

    _isLoadingUser = false;
    notifyListeners();
  }

  Future getMenus() async {
    _notifyMenusLoading();
    _menusResponse = await repository.getCategories();
    _notifyMenusResponse();
  }

  void _notifyMenusLoading() {
    _menusResponse = ApiResponse.loading('');
    _showMenus = true;
    _loadingMenus = true;
    notifyListeners();
  }

  void _notifyMenusResponse() {
    _loadingMenus = false;
    if (_menusResponse.status == ApiStatus.success) {
      final menus = _menusResponse.data;
      if (menus == null || menus.isEmpty) {
        _showMenus = false;
      } else {
        _menus = menus;
      }
    }
    notifyListeners();
  }
}
