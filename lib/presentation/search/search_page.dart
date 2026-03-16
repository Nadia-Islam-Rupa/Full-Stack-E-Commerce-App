import 'package:ai_powered_e_commerce_app/presentation/home/product_card.dart';
import 'package:ai_powered_e_commerce_app/presentation/search/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchProductProvider(query));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 239, 239),
        title: Text("Search: $query"),
        centerTitle: true,
      ),
      body: results.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        },
      ),
    );
  }
}
