import 'package:ai_powered_e_commerce_app/data/category/category_model.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final Category category;

  const ProductListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Center(
        child: Text(
          "Products of ${category.name}",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
