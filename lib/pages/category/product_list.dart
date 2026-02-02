import 'package:ai_powered_e_commerce_app/data/sub_category/sub_cat.dart';
import 'package:ai_powered_e_commerce_app/pages/category/provider/sub_cat_provider.dart';
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
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(subCategories[index]),
                    selected: false,
                    onSelected: (_) {
                      ref.read(selectedSubCategoryProvider.notifier).state =
                          subCategories[index];
                    },
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
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Text("data");
              },
            ),
          ),
        ],
      ),
    );
  }
}
