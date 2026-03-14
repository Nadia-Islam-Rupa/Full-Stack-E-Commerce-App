class SubCategory {
  final String id;
  final String name;
  final String categoryId;
  final String image;

  SubCategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      image: json['image_url'],
    );
  }
}
