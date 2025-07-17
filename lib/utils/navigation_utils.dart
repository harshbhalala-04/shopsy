import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopsy/constants/app_constants.dart';
import 'package:shopsy/screens/cart_screen.dart';
import 'package:shopsy/screens/home_screen.dart';
import 'package:shopsy/screens/product_detail_screen.dart';
import 'package:shopsy/screens/order_confirmation_screen.dart';

class NavigationUtils {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case routeHomeScreen:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(), settings: settings);
      case routeProductDetailScreen:
        return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
                  productId: args?[NavigationParams.productId],
                  fromTrendingProduct: args?[NavigationParams.fromTrendingProduct],
                ),
            settings: settings);
      case routeCartScreen:
        return MaterialPageRoute(
            builder: (_) => const CartScreen(), settings: settings);
      case routeOrderConfirmationScreen:
        return MaterialPageRoute(
            builder: (_) => const OrderConfirmationScreen(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) {
          return const HomeScreen();
        });
    }
  }

  static void pushReplacement(String routeName, {Object? arguments}) {
    NavigationParams.navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(String routeName, {Object? arguments}) {
    return NavigationParams.navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static void pop({dynamic args}) {
    NavigationParams.navigatorKey.currentState!.pop(args);
  }

  static Future<dynamic> pushAndRemoveUntil(String routeName,
      {Object? arguments, String? routeToBeRemoved, String? alternetiveRoute}) {
    return NavigationParams.navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) {
      if (routeToBeRemoved != null && alternetiveRoute != null) {
        return route.settings.name == routeToBeRemoved ||
            route.settings.name == alternetiveRoute;
      }
      if (routeToBeRemoved != null) {
        return route.settings.name == routeToBeRemoved;
      }
      return false;
    }, arguments: arguments);
  }
}

class NavigationParams {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static const productId = "productId";
  static const fromTrendingProduct = "fromTrendingProduct";
}
