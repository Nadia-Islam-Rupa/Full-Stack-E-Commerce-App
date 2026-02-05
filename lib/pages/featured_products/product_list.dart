import 'package:ai_powered_e_commerce_app/data/sub_category/sub_cat.dart';

import 'package:ai_powered_e_commerce_app/pages/featured_products/product_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerWidget {
  final String category;

  const ProductListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategories = subcategory[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text(
          category,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Subcategory bar
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        subCategories[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Products
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                childAspectRatio: 0.7,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const FeatureProductCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
