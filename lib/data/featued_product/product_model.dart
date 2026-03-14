class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String subCategoryId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.subCategoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image_url'],
      subCategoryId: json['sub_category_id'],
    );
  }
}
