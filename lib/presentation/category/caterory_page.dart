import 'package:ai_powered_e_commerce_app/presentation/category/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'category_card.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: categoryAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
          data: (categories) => GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(category: categories[index]);
            },
          ),
        ),
      ),
    );
  }
}
