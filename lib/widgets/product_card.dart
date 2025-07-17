import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsy/models/product_overview_dto.dart';
import 'package:shopsy/providers/cart_provider.dart';

import '../models/cart_item.dart';
import '../utils/color_utils.dart';

class ProductCard extends StatelessWidget {
  final ProductOverviewDto productOverviewDto;
  const ProductCard({super.key, required this.productOverviewDto});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final isInCart = cartProvider.isInCart(productOverviewDto.id);
    final quantity = cartProvider.getQuantityOfCartItem(productOverviewDto.id);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Hero(
                tag: "product_${productOverviewDto.id}",
                child: Container(
                  padding: const EdgeInsets.only(top: 12),
                  alignment: Alignment.center,
                  child: Image(
                    width: 100,
                    fit: BoxFit.contain,
                    image: AssetImage(productOverviewDto.productImage),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: isInCart
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              onTap: () {
                                cartProvider
                                    .decreaseQuantity(productOverviewDto.id);
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              onTap: () {
                                cartProvider
                                    .increaseQuantity(productOverviewDto.id);
                              },
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          cartProvider.addToCart(
                            CartItem(
                              id: productOverviewDto.id,
                              name: productOverviewDto.name,
                              image: productOverviewDto.productImage,
                              salePrice: productOverviewDto.salePrice,
                              actualPrice: productOverviewDto.actualPrice
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'ADD',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      productOverviewDto.name,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_rate,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      Text(
                        (productOverviewDto.totalRatings /
                                productOverviewDto.totalRatingsGiven)
                            .toStringAsFixed(1),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Text(
                  '₹${productOverviewDto.salePrice}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '₹${productOverviewDto.actualPrice}',
                style:  TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 14,
                  color: ColorUtils.lightGreyColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.only(left: 4),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(49, 237, 56, 0.32),
                    borderRadius: BorderRadius.all(Radius.elliptical(9, 9))),
                child: Text(
                  '${(((productOverviewDto.actualPrice - productOverviewDto.salePrice) / productOverviewDto.actualPrice) * 100).toInt()}% off',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(29, 165, 7, 1),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
