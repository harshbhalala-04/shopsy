import 'package:flutter/material.dart';
import 'package:shopsy/constants/app_constants.dart';
import 'package:shopsy/models/trending_product.dart';
import 'package:shopsy/utils/image_utils.dart';
import 'package:shopsy/utils/navigation_utils.dart';

class TrendingProductCard extends StatelessWidget {
  final TrendingProduct trendingProduct;
  const TrendingProductCard({super.key, required this.trendingProduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationUtils.push(routeProductDetailScreen, arguments: {
          NavigationParams.productId: trendingProduct.id,
          NavigationParams.fromTrendingProduct: true,
        });
      },
      child: Container(
        width: 140,
        height: 160,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                bgTrendingProduct,
                fit: BoxFit.cover,
                width: 140,
                height: 160,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                icDrop,
                width: 60,
                height: 60,
              ),
            ),
            Positioned(
              bottom: 80,
              child: Hero(
                tag: "trending_product_${trendingProduct.id}",
                child: Image.asset(
                  trendingProduct.image,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    trendingProduct.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2),
                  ),
                  Text(
                    'Up to ${trendingProduct.discountPercentage.toInt()}% off',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
