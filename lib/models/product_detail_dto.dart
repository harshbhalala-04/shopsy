class ProductDetailDto {
  final String id;
  final String name;
  final String description;
  final double salePrice;
  final double actualPrice;
  final int stock;
  final int lowStockQuantityAlert;
  final List<String> productImageList;
  final int totalRatings;
  final int totalRatingsGiven;
  final List<KeyInformation> keyInformation;

  ProductDetailDto({
    required this.id,
    required this.name,
    required this.description,
    required this.salePrice,
    required this.actualPrice,
    required this.stock,
    required this.lowStockQuantityAlert,
    required this.productImageList,
    required this.totalRatings,
    required this.totalRatingsGiven,
    required this.keyInformation,
  });

  factory ProductDetailDto.fromJson(Map<String, dynamic> json) {
    return ProductDetailDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      salePrice: (json['salePrice'] as num).toDouble(),
      actualPrice: (json['actualPrice'] as num).toDouble(),
      stock: json['stock'],
      lowStockQuantityAlert: json['lowStockQuantityAlert'],
      productImageList: List<String>.from(json['productImageList']),
      totalRatings: json['totalRatings'],
      totalRatingsGiven: json['totalRatingsGiven'],
      keyInformation: (json['keyInformation'] as List)
          .map((e) => KeyInformation.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'salePrice': salePrice,
      'actualPrice': actualPrice,
      'stock': stock,
      'lowStockQuantityAlert': lowStockQuantityAlert,
      'productImageList': productImageList,
      'totalRatings': totalRatings,
      'totalRatingsGiven': totalRatingsGiven,
      'keyInformation': keyInformation.map((e) => e.toJson()).toList(),
    };
  }
}

class KeyInformation {
  final String paramName;
  final String paramValue;

  KeyInformation({
    required this.paramName,
    required this.paramValue,
  });

  factory KeyInformation.fromJson(Map<String, dynamic> json) {
    return KeyInformation(
      paramName: json['paramName'],
      paramValue: json['paramValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paramName': paramName,
      'paramValue': paramValue,
    };
  }
}