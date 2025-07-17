import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsy/constants/app_constants.dart';
import 'package:shopsy/main.dart';
import 'package:shopsy/utils/navigation_utils.dart';
import 'package:tuple/tuple.dart';
import '../providers/cart_provider.dart';

class CartOverlayWidget extends StatefulWidget {
  const CartOverlayWidget({super.key});

  @override
  State<CartOverlayWidget> createState() => _CartOverlayWidgetState();
}

class _CartOverlayWidgetState extends State<CartOverlayWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final totalItems = context.read<CartProvider>().totalUniqueCartItems;
    if (totalItems > 0) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStackedImages(List<String> images) {
    return SizedBox(
      width: 80,
      height: 40,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(images.length, (index) {
          final double leftOffset = index * 20;
          return Positioned(
            left: leftOffset,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(images[index]),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, Tuple2<int, int>>(
      selector: (_, provider) =>
          Tuple2(provider.totalUniqueCartItems, provider.totalCartItems),
      builder: (context, cartData, _) {
        final totalUniqueCartItems = cartData.item1;
        final totalCartItems = cartData.item2;

        if (totalUniqueCartItems == 0) return const SizedBox.shrink();

        final imagePaths =
            context.read<CartProvider>().getLastThreeImagePaths();
        return ValueListenableBuilder<bool>(
          valueListenable: isBottomNavigationBarFirst,
          builder: (context, isBottomNavigationBarFirst, _) {
            return Positioned(
              bottom:  (ModalRoute.of(context)!.settings.name == routeHomeScreen || isBottomNavigationBarFirst) ? kBottomNavigationBarHeight * 2 : 20,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _offsetAnimation,
                child: Center(
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: () {
                        NavigationUtils.push(routeCartScreen);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildStackedImages(imagePaths),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'View Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$totalCartItems ${totalCartItems == 1 ? "ITEM" : "ITEMS"}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }
}
