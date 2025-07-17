import 'package:flutter/material.dart';
import 'package:shopsy/models/product_detail_dto.dart';
import 'package:shopsy/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  ProductDetailDto? productDetailDto;

  getProductByProductId(String productId) {
    productDetailDto = ProductService().getProductDetail(productId);
    notifyListeners();
  }
}