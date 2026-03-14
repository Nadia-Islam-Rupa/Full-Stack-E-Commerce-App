import 'package:ai_powered_e_commerce_app/presentation/featured_products/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/sub_cat_provider.dart';

class SubCategoryPage extends ConsumerWidget {
  final String categoryId;
  final String title;

  const SubCategoryPage({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategories = ref.watch(subCategoryProvider(categoryId));

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: subCategories.when(
        data: (subs) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final sub = subs[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductPage(subCategoryId: sub.id, title: sub.name),
                    ),
                  );
                },
                child: Card(
                  child: Center(
                    child: Text(
                      sub.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
