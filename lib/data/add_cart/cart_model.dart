class Cart {
  final String productId;
  final String name;
  final String image;
  final double price;

  Cart({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "name": name,
      "image": image,
      "price": price,
    };
  }
}
