import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/app_constants.dart';
import '../models/cart_item.dart';
import '../utils/navigation_utils.dart';

class CartProvider extends ChangeNotifier {
  final _storage = GetStorage();

  final Map<String, CartItem> _cartItemsMap = {};

  List<CartItem> get cartItems => _cartItemsMap.values.toList();

  double get totalCartPrice =>
      _cartItemsMap.values.fold(0, (sum, item) => sum + item.totalPrice);

  double get totalActualPriceOfCart =>
      _cartItemsMap.values.fold(0, (sum, item) => sum + (item.actualPrice * item.quantity));

  double get totalDiscountOnCart => totalActualPriceOfCart - totalCartPrice;

  int get totalCartItems =>
      _cartItemsMap.values.fold(0, (sum, item) => sum + item.quantity);

  int get totalUniqueCartItems => _cartItemsMap.keys.length;

  bool isCheckoutProcessing = false;

  bool isInCart(String productId) {
    return _cartItemsMap.containsKey(productId);
  }

  List<String> getLastThreeImagePaths() {
    return _cartItemsMap.values
        .map((e) => e.image)
        .toList()
        .reversed
        .take(3)
        .toList();
  }

  int getQuantityOfCartItem(String productId) {
    return _cartItemsMap.containsKey(productId) &&
            _cartItemsMap[productId] != null
        ? _cartItemsMap[productId]!.quantity
        : 0;
  }

  void addToCart(CartItem item) {
    if (_cartItemsMap.containsKey(item.id)) {
      _cartItemsMap[item.id]!.quantity += 1;
    } else {
      _cartItemsMap[item.id] = item;
    }
    saveCartToStorage();
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItemsMap.remove(id);
    saveCartToStorage();
    notifyListeners();
  }

  void increaseQuantity(String id) {
    if (_cartItemsMap.containsKey(id)) {
      _cartItemsMap[id]!.quantity += 1;
      saveCartToStorage();
      notifyListeners();
    }
  }

  void decreaseQuantity(String id) {
    if (_cartItemsMap.containsKey(id)) {
      if (_cartItemsMap[id]!.quantity > 1) {
        _cartItemsMap[id]!.quantity -= 1;
      } else {
        _cartItemsMap.remove(id);
      }
      saveCartToStorage();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItemsMap.clear();
    saveCartToStorage();
    notifyListeners();
  }

  void saveCartToStorage() {
    final cartJson = _cartItemsMap.values.map((item) => item.toJson()).toList();
    _storage.write('cart', cartJson);
  }

  void loadCartFromStorage() {
    final cartData = _storage.read<List>('cart');
    if (cartData != null) {
      _cartItemsMap.clear();
      for (var e in cartData) {
        final item = CartItem.fromJson(Map<String, dynamic>.from(e));
        _cartItemsMap[item.id] = item;
      }
    }
    notifyListeners();
  }

  Future<void> checkout() async {
    isCheckoutProcessing = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    isCheckoutProcessing = false;
    notifyListeners();
    NavigationUtils.push(routeOrderConfirmationScreen);
    clearCart();
  }
}
