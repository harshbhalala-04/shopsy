class CartItem {
  final String id;
  final String name;
  final String image;
  final double salePrice;
  final double actualPrice;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.salePrice,
    required this.actualPrice,
    this.quantity = 1,
  });

  double get totalPrice => salePrice * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      salePrice: (json['salePrice'] as num).toDouble(),
      actualPrice: (json['actualPrice'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'salePrice': salePrice,
      'actualPrice': actualPrice,
      'quantity': quantity,
    };
  }
}
