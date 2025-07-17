import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsy/providers/cart_provider.dart';
import 'package:shopsy/widgets/primary_app_bar.dart';

import '../models/cart_item.dart';
import '../utils/style_utils.dart';
import '../widgets/app_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        title: "My Cart",
      ),
      body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
        return cartProvider.cartItems.isEmpty
            ? const Center(
                child: Text("No items in cart"),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartProvider.totalUniqueCartItems,
                        itemBuilder: (context, index) {
                          return _cartItemWidget(
                            cartProvider.cartItems[index],
                            cartProvider,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _deliveryDetailsWidget(),
                      const SizedBox(
                        height: 16,
                      ),
                      showPriceDetailWidget(cartProvider),
                    ],
                  ),
                ),
              );
      }),
      bottomNavigationBar:
          Consumer<CartProvider>(builder: (context, cartProvider, _) {
        return cartProvider.cartItems.isEmpty
            ? const SizedBox()
            : getBottomAppBar(cartProvider);
      }),
    );
  }

  Widget getBottomAppBar(CartProvider cartProvider) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "₹${cartProvider.totalCartPrice}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Bill",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                AppButton(
                  onPressed: () {
                    cartProvider.checkout();
                  },
                  isLoading: cartProvider.isCheckoutProcessing,
                  text: "CHECKOUT",
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  borderRadius: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showPriceDetailWidget(CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price Details",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total MRP",
                  style: Theme.of(context).textTheme.displaySmall),
              Text(
                "₹${cartProvider.totalActualPriceOfCart}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount on MRP",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  "${cartProvider.totalDiscountOnCart}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping Charges",
                    style: Theme.of(context).textTheme.displaySmall),
                Text(
                  "0",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Divider(
              color: Theme.of(context).dividerColor
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total amount",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "₹${cartProvider.totalCartPrice}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _deliveryDetailsWidget() {
    return Container(
      decoration: customBoxDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.zero,
            titleAlignment: ListTileTitleAlignment.top,
            dense: true,
            leading: const Icon(Icons.home_outlined),
            title: Text(
              "Delivery at Home",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              "B 206 Avenue, Rudra Park Society, SP road, Ahmedabad, Gujarat",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.zero,
            titleAlignment: ListTileTitleAlignment.top,
            dense: true,
            leading: const Icon(Icons.phone_outlined),
            title: RichText(
                text: TextSpan(
              children: [
                TextSpan(
                  text: "Harsh Bhalala, ",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                TextSpan(
                  text: "+91-6354969597",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  Widget _cartItemWidget(CartItem cartItem, CartProvider cartProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: customBoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: customBoxDecoration(
                      color: const Color.fromRGBO(249, 249, 249, 1)),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    cartItem.image,
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.name,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "In Stock",
                    style: TextStyle(color: Colors.green),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "₹${(cartItem.totalPrice)}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cartProvider.decreaseQuantity(cartItem.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          decoration: customBoxDecoration(
                            color: const Color.fromRGBO(227, 227, 227, 1),
                          ),
                          child: const Icon(
                            Icons.remove,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        (cartProvider
                            .getQuantityOfCartItem(cartItem.id)
                            .toString()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          cartProvider.increaseQuantity(cartItem.id);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            decoration: customBoxDecoration(
                              color: Colors.black,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
