class SubCategory {
  final String id;
  final String name;
  final String categoryId;

  SubCategory({required this.id, required this.name, required this.categoryId});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
    );
  }
}
