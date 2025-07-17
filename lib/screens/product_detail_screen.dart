import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shopsy/models/cart_item.dart';
import 'package:shopsy/models/product_detail_dto.dart';
import 'package:shopsy/providers/cart_provider.dart';
import 'package:shopsy/providers/product_provider.dart';
import 'package:shopsy/utils/image_utils.dart';
import 'package:shopsy/utils/navigation_utils.dart';
import 'package:shopsy/widgets/scaffold_with_cart_overlay.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/color_utils.dart';
import '../widgets/app_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final bool fromTrendingProduct;
  const ProductDetailScreen(
      {super.key, required this.productId, required this.fromTrendingProduct});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;
  late final ProductProvider productProvider;

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(
        NavigationParams.navigatorKey.currentContext!,
        listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      productProvider.getProductByProductId(widget.productId);
    });
    super.initState();
  }

  @override
  void dispose() {
    productProvider.productDetailDto = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWithCartOverlay(
        body: Consumer<ProductProvider>(builder: (context, provider, _) {
          if (provider.productDetailDto == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          ProductDetailDto productDetailDto = provider.productDetailDto!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: widget.fromTrendingProduct
                        ? "trending_product_${productDetailDto.id}"
                        : "product_${productDetailDto.id}",
                    child: productImageWidget(productDetailDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: productNameWidget(productDetailDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: productDescriptionWidget(productDetailDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: productStatsWidget(productDetailDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: productSalePriceWidget(productDetailDto),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: productServiceHighlighRow(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: productKeyInformationWidget(productDetailDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ratingsWidget(productDetailDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: customerReviewWidget(isTitle: true),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: Selector<ProductProvider, ProductDetailDto?>(
        selector: (context, provider) => provider.productDetailDto,
        builder: (context, productDetailDto, _) {
          if (productDetailDto == null) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                Consumer<CartProvider>(builder: (context, cartProvider, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cartProvider.isInCart(productDetailDto.id)
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 20),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(232, 232, 232, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        offset: const Offset(
                                          0,
                                          2,
                                        ),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(22)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        cartProvider.decreaseQuantity(
                                            productDetailDto.id);
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${cartProvider.getQuantityOfCartItem(productDetailDto.id)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        cartProvider.increaseQuantity(
                                            productDetailDto.id);
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 20),
                              child: AppButton(
                                onPressed: () {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .addToCart(CartItem(
                                    id: productDetailDto.id,
                                    name: productDetailDto.name,
                                    image: productDetailDto.productImageList[0],
                                    salePrice: productDetailDto.salePrice,
                                    actualPrice: productDetailDto.actualPrice,
                                  ));
                                },
                                text: "Add to Cart",
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                borderRadius: 26,
                                buttonHeight: 50,
                                fontSize: 14,
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2,
                              ),
                            ),
                    ],
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Column customerReviewWidget({required bool isTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTitle
            ? Text("Customer Review",
                style: Theme.of(context).textTheme.headlineMedium)
            : const SizedBox(),
        isTitle
            ? const SizedBox(
                height: 8,
              )
            : const SizedBox(),
        Text(
          "Effectiveness",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          color: Theme.of(context).primaryColor,
                          height: 14,
                          width:
                              0.7 * (MediaQuery.of(context).size.width * 0.5)),
                      Container(
                          color:
                              Theme.of(context).textTheme.displaySmall!.color,
                          height: 14,
                          width:
                              0.3 * (MediaQuery.of(context).size.width * 0.5)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Outstanding",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("83%",
                        style: Theme.of(context).textTheme.displaySmall),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Column ratingsWidget(ProductDetailDto productDetailDTO) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ratings", style: Theme.of(context).textTheme.headlineMedium),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "3.5",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star_rate,
                        color: index >= 3
                            ? ColorUtils.lightGreyColor
                            : Theme.of(context).primaryColor,
                      ),
                    ).toList(),
                  ),
                  Text(
                    "79 ratings",
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorUtils.lightGreyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: List.generate(
                    5,
                    (index) => Row(
                      children: [
                        const Text("5"),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Icon(
                            Icons.star_rate,
                            color: ColorUtils.lightGreyColor,
                          ),
                        ),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.6,
                            minHeight: 14,
                            color: Theme.of(context).primaryColor,
                            backgroundColor: ColorUtils.lightGreyColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "61%",
                            style: TextStyle(
                              color: ColorUtils.lightGreyColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row productServiceHighlighRow() {
    return Row(
      children: [
        itemServiceHighlight(icon: Icons.verified, title: "1-Year Warranty"),
        itemServiceHighlight(icon: Icons.support_agent, title: "24/7 Support"),
        itemServiceHighlight(
            icon: Icons.local_shipping, title: "Fast Delivery"),
      ],
    );
  }

  Expanded itemServiceHighlight(
      {required IconData icon, required String title}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 244, 248),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Colors.black),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Column productKeyInformationWidget(ProductDetailDto productDetailDTO) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Information: ",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: productDetailDTO.keyInformation.map((info) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      info.paramName,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      info.paramValue,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodySmall
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Row productSalePriceWidget(ProductDetailDto productDetailDTO) {
    return Row(
      children: [
        Text(
          "₹${productDetailDTO.salePrice}",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "₹${productDetailDTO.actualPrice}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.lineThrough,
                color: ColorUtils.lightGreyColor),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.only(left: 4),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(49, 237, 56, 0.32),
              borderRadius: BorderRadius.all(Radius.elliptical(9, 9))),
          child: Text(
            '${(((productDetailDTO.actualPrice - productDetailDTO.salePrice) / productDetailDTO.actualPrice) * 100).toInt()}% off',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(29, 165, 7, 1),
            ),
          ),
        )
      ],
    );
  }

  Row productStatsWidget(ProductDetailDto productDetailDTO) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.star,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 4,
            ),
            productDetailDTO.totalRatings == 0
                ? const Text("0")
                : Text(
                    (productDetailDTO.totalRatings /
                            productDetailDTO.totalRatingsGiven)
                        .toStringAsFixed(1),
                  ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 4,
            ),
            const Text("1 km"),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.timer,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 4,
            ),
            const Text("20 min")
          ],
        ),
      ],
    );
  }

  Row productDescriptionWidget(ProductDetailDto productDetailDTO) {
    return Row(
      children: [
        Flexible(
          child: Text(
            productDetailDTO.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Row productNameWidget(ProductDetailDto productDetailDTO) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(productDetailDTO.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(letterSpacing: 0.3, fontSize: 20)),
        ),
        productDetailDTO.stock <= productDetailDTO.lowStockQuantityAlert
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "(Only ${productDetailDTO.stock} Products left)",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromRGBO(255, 0, 0, 1)),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Row productImageWidget(ProductDetailDto productDetailDTO) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            NavigationUtils.pop();
          },
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                items: productDetailDTO.productImageList
                    .map(
                      (item) => Image.asset(
                        item,
                        fit: BoxFit.contain,
                        height: 300,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    enlargeFactor: 0.5,
                    aspectRatio: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    }),
                carouselController: _controller,
              ),
              const SizedBox(height: 10),
              AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: productDetailDTO.productImageList.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Theme.of(context).primaryColor,
                  dotColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Image.asset(icShare),
          ],
        ),
      ],
    );
  }
}
