import 'package:ai_powered_e_commerce_app/data/category/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          // backgroundImage: AssetImage(category.image),
        ),
        const SizedBox(height: 6),
        Text(
          category.name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
