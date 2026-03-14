import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider/product_provider.dart';

class ProductPage extends ConsumerWidget {
  final String subCategoryId;
  final String title;

  const ProductPage({
    super.key,
    required this.subCategoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider(subCategoryId));

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: products.when(
        data: (items) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final product = items[index];

              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(product.image, fit: BoxFit.cover),
                    ),
                    Text(product.name),
                    Text("\$${product.price}"),
                  ],
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
