import 'package:flutter/material.dart';
import 'package:shopsy/models/product_overview_dto.dart';
import 'package:shopsy/models/trending_product.dart';
import 'package:shopsy/service/product_service.dart';
import 'package:shopsy/utils/image_utils.dart';

class HomeProvider with ChangeNotifier {
  List<ProductOverviewDto> productsList = [];
  List<TrendingProduct> trendingProductsList = [];

  getProductsList() {
    productsList = ProductService().getProductsList();
    notifyListeners();
  }

  getTrendingProductList() {
    trendingProductsList.addAll(ProductService().getTrendingProductList());
    notifyListeners();
  }
}
