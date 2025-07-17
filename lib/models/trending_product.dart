class TrendingProduct {
  final String id;
  final String image;
  final String name;
  final double discountPercentage;

  TrendingProduct({
    required this.id,
    required this.image,
    required this.name,
    required this.discountPercentage,
  });

  factory TrendingProduct.fromJson(Map<String, dynamic> json) {
    return TrendingProduct(
      id: json['id'],
      name: json['name'],
      image: json['productImage'],
      discountPercentage: json['discountPercentage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'discountPercentage': discountPercentage,
    };
  }
}
