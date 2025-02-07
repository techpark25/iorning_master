import 'package:flutter/material.dart';

import '../presentation/splash/splash_screen.dart';

import '../presentation/main/main_screen.dart';
import '../presentation/user/login/login_screen.dart';
import 'routes.dart';

class RouteGenerator {
  static String initialRoute = splashRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //   case addressListRoute:
      //     return SlideLeftRoute(page: const AddressListScreen());

      //   case addressDetailRoute:
      //     final address = settings.arguments as Address?;
      //     return MaterialPageRoute(
      //       builder: (_) => AddressDetailScreen(address: address),
      //     );

      //   case cartRoute:
      //     return MaterialPageRoute(
      //       builder: (_) => const CartScreen(),
      //       settings: settings,
      //     );

      //   case languageSettingsRoute:
      //     return SlideLeftRoute(page: const LanguageSettings());

      case mainRoute:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );

      //   case notificationsRoute:
      //     return SlideLeftRoute(page: const NotificationListScreen());

      //   case orderAddressSelectionRoute:
      //     return SlideLeftRoute(page: const AddressSelectionScreen());

      //   case orderListRoute:
      //     return SlideLeftRoute(page: const OrderListScreen());

      //   case orderDetailRoute:
      //     final orderDetail = settings.arguments as OrderDetailArgs;
      //     return SlideLeftRoute(
      //       page: OrderDetailScreen(
      //         orderId: orderDetail.orderId!,
      //       ),
      //     );

      //   case orderPaymentSelectionRoute:
      //     final args = settings.arguments as PaymentSelectionScreenArgs;
      //     return SlideLeftRoute(
      //       page: PaymentSelectionScreen(
      //         cartData: args.cartData,
      //         address: args.address,
      //       ),
      //     );

      //   case orderSummaryRoute:
      //     final args = settings.arguments as OrderSummaryScreenArgs;
      //     return SlideLeftRoute(
      //       page: OrderSummaryScreen(address: args.address!),
      //     );

      //   case orderSuccessRoute:
      //     return SlideLeftRoute(page: const OrderSuccess());

      //   case productDetailsRoute:
      //     final product = settings.arguments as Product;
      //     return SlideLeftRoute(
      //       page: ProductDetailsScreen(product: product),
      //     );

      //   case productsRoute:
      //     final args = settings.arguments as ProductListArgs;
      //     return SlideLeftRoute(page: ProductListScreen(args: args));

      //   case searchRoute:
      //     return MaterialPageRoute(builder: (_) => const SearchPage());

      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case userLoginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      //   case userLoginSuccessRoute:
      //     return MaterialPageRoute(builder: (_) => const SuccessScreen());

      //   case userProfileRoute:
      //     return SlideLeftRoute(page: const UserProfileScreen());

      

      //   case userVerificationRoute:
      //     final args = settings.arguments as VerifyScreenArgs;
      //     return MaterialPageRoute(builder: (_) => VerifyScreen(args: args));

      //   case wishlistRoute:
      //     return SlideLeftRoute(page: const WishlistScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
