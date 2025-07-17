import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsy/providers/home_provider.dart';
import 'package:shopsy/widgets/trending_product_card.dart';

class TrendingProductSection extends StatefulWidget {
  const TrendingProductSection({super.key});

  @override
  State<TrendingProductSection> createState() =>
      _TrendingProductSectionState();
}

class _TrendingProductSectionState
    extends State<TrendingProductSection> {
  final ValueNotifier<double> horizontalPaddingNotifier =
      ValueNotifier<double>(20.0);

  @override
  void dispose() {
    horizontalPaddingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels > 0 &&
            horizontalPaddingNotifier.value != 0) {
          horizontalPaddingNotifier.value = 0;
        } else if (scrollNotification.metrics.pixels == 0 &&
            horizontalPaddingNotifier.value != 20) {
          horizontalPaddingNotifier.value = 20;
        }
        return true;
      },
      child: ValueListenableBuilder<double>(
        valueListenable: horizontalPaddingNotifier,
        builder: (context, horizontalPadding, _) {
          return Padding(
            padding: EdgeInsets.only(left: horizontalPadding),
            child: SizedBox(
              height: 175,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: provider.trendingProductsList
                            .map(
                              (trendingProduct) => TrendingProductCard(
                                trendingProduct: trendingProduct,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
