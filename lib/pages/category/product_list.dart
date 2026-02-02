import 'package:ai_powered_e_commerce_app/data/category/category_data.dart';
import 'package:ai_powered_e_commerce_app/pages/home/category.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Fashion',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CategoryItem(category: categories[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
