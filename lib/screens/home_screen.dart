import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shopsy/constants/app_constants.dart';
import 'package:shopsy/main.dart';
import 'package:shopsy/models/product_overview_dto.dart';
import 'package:shopsy/providers/home_provider.dart';
import 'package:shopsy/utils/image_utils.dart';
import 'package:shopsy/utils/navigation_utils.dart';
import 'package:shopsy/widgets/product_card.dart';
import 'package:shopsy/widgets/scaffold_with_cart_overlay.dart';
import 'package:shopsy/widgets/trending_product_section.dart';

import '../providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      HomeProvider homeProvider = Provider.of<HomeProvider>(
          NavigationParams.navigatorKey.currentContext!,
          listen: false);
      CartProvider cartProvider = Provider.of<CartProvider>(
          NavigationParams.navigatorKey.currentContext!,
          listen: false);
      homeProvider.getProductsList();
      homeProvider.getTrendingProductList();
      cartProvider.loadCartFromStorage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            icLogo,
            width: 130,
            height: 130,
          ),
          actions: [
            Selector<CartProvider, int>(
              selector: (context, cartProvider) =>
                  cartProvider.totalUniqueCartItems,
              builder: (context, totalItems, _) {
                return GestureDetector(
                  onTap: () {
                    NavigationUtils.push(routeCartScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart_outlined, size: 28),
                        if (totalItems > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: BodyWithCartOverlay(
          body: Consumer<HomeProvider>(builder: (context, provider, _) {
            return CustomScrollView(
              physics: const ScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Special Offer for you',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8),
                              width: 5),
                        ),
                        child: const Image(
                          image: AssetImage("assets/images/offer.jpg"),
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        child: Text(
                          "Trending Now",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const TrendingProductSection(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        child: Text(
                          "Explore Products",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverAlignedGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: provider.productsList.length,
                    itemBuilder: (context, index) {
                      ProductOverviewDto productOverviewDto =
                          provider.productsList[index];
                      return GestureDetector(
                        onTap: () {
                          if (Provider.of<CartProvider>(context, listen: false).totalCartItems == 0) {
                            isBottomNavigationBarFirst.value = true;
                          } else {
                            isBottomNavigationBarFirst.value = false;
                          }
                          NavigationUtils.push(routeProductDetailScreen,
                              arguments: {
                                NavigationParams.productId:
                                    productOverviewDto.id,
                                NavigationParams.fromTrendingProduct: false,
                              });
                        },
                        child: ProductCard(
                          productOverviewDto: productOverviewDto,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
