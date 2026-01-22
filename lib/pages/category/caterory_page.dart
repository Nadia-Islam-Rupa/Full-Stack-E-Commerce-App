import 'package:ai_powered_e_commerce_app/data/category/category_data.dart';
import 'package:ai_powered_e_commerce_app/pages/category/category_card.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryCard(category: category);
          },
        ),
      ),
    );
  }
}
