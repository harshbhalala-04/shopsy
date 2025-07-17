class ProductOverviewDto {
  final String id;
  final String name;
  final double salePrice;
  final double actualPrice;
  final int stock;
  final String productImage;
  final int totalRatings;
  final int totalRatingsGiven;

  ProductOverviewDto({
    required this.id,
    required this.name,
    required this.salePrice,
    required this.actualPrice,
    required this.stock,
    required this.productImage,
    required this.totalRatings,
    required this.totalRatingsGiven,
  });

  factory ProductOverviewDto.fromJson(Map<String, dynamic> json) {
    return ProductOverviewDto(
      id: json['id'],
      name: json['name'],
      salePrice: (json['salePrice'] as num).toDouble(),
      actualPrice: (json['actualPrice'] as num).toDouble(),
      stock: json['stock'],
      productImage: json['productImage'],
      totalRatings: json['totalRatings'],
      totalRatingsGiven: json['totalRatingsGiven'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'salePrice': salePrice,
      'actualPrice': actualPrice,
      'stock': stock,
      'productImage': productImage,
      'totalRatings': totalRatings,
      'totalRatingsGiven': totalRatingsGiven,
    };
  }
}
