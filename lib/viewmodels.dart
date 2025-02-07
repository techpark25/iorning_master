import 'package:provider/provider.dart';

import 'presentation/address/address_view_model.dart';
import 'presentation/cart/order_create_view_model.dart';
import 'presentation/home/home_view_model.dart';
import 'presentation/orders/detail/order_detail_view_model.dart';
import 'presentation/orders/list/order_list_view_model.dart';
import 'presentation/product/cart_view_model.dart';
import 'presentation/product/product_view_model.dart';
import 'presentation/profile/profile_view_model.dart';
import 'presentation/splash/splash_view_model.dart';
import 'presentation/user/login/login_viewmodel.dart';
import 'presentation/user/register/register_view_model.dart';

List viewmodelProviders = [
  ChangeNotifierProvider(create: (_) => OrderDetailViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => HomeViewModel()),
  ChangeNotifierProvider(create: (_) => SplashViewModel()),
  ChangeNotifierProvider(create: (_) => OrderListViewModel()),
  ChangeNotifierProvider(create: (_) => ProductViewModel()),
  ChangeNotifierProvider(create: (_) => ProfileViewModel()),
  ChangeNotifierProvider(create: (_) => CartViewModel()),
  ChangeNotifierProvider(create: (_) => OrderCreateViewModel()),
  ChangeNotifierProvider(create: (_) => AddressViewModel()),
];
