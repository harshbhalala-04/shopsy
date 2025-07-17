import 'package:shopsy/constants/app_constants.dart';
import 'package:shopsy/models/product_detail_dto.dart';
import 'package:shopsy/models/product_overview_dto.dart';
import 'package:shopsy/models/trending_product.dart';

class ProductService {
  List<ProductOverviewDto> getProductsList() {
    return productsList
        .map((json) => ProductOverviewDto.fromJson(json))
        .toList();
  }

  List<TrendingProduct> getTrendingProductList() {
    return productsList
        .where((json) => json['isTrendingProduct'] == true)
        .map((json) {
      final actualPrice = json['actualPrice'] ?? 0;
      final salePrice = json['salePrice'] ?? 0;
      final discountedPercentage = actualPrice != 0
          ? (((actualPrice - salePrice) / actualPrice) * 100)
          : 0;

      json['discountPercentage'] = discountedPercentage;

      return TrendingProduct.fromJson(json);
    }).toList();
  }

  ProductDetailDto? getProductDetail(String productId) {
    Map<String, dynamic>? productMap = productsList.firstWhere(
        (product) =>
            product.containsKey("id") ? product["id"] == productId : false,
        orElse: () => {});
    if (productMap.isNotEmpty) {
      return ProductDetailDto.fromJson(productMap);
    }
    return null;
  }
}
