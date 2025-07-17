import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shopsy/constants/app_constants.dart';
import 'package:shopsy/providers/cart_provider.dart';
import 'package:shopsy/providers/home_provider.dart';
import 'package:shopsy/providers/product_provider.dart';

import 'utils/navigation_utils.dart';
import 'utils/theme_utils.dart';

ValueNotifier<bool> isBottomNavigationBarFirst = ValueNotifier(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

// To Observe route and manage back flow with navigation
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Shopsy',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationParams.navigatorKey,
        navigatorObservers: [
          routeObserver,
        ],
        theme: primaryTheme,
        initialRoute: routeHomeScreen,
        onGenerateRoute: NavigationUtils.generateRoute,
      ),
    );
  }
}
