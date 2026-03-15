import 'package:ai_powered_e_commerce_app/data/Favorite/favorite_model.dart';
import 'package:ai_powered_e_commerce_app/data/add_cart/cart_model.dart';
import 'package:ai_powered_e_commerce_app/presentation/cart/cart_provider.dart';
import 'package:ai_powered_e_commerce_app/presentation/favorite/fav_provider.dart';
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
    final favorites = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: products.when(
        data: (items) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = items[index];
              final isFavorite = favorites.any(
                (favorite) => favorite.productId == product.id,
              );

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// IMAGE + HEART ICON
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /// HEART ICON
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.black,
                                size: 20,
                              ),
                              onPressed: () async {
                                if (isFavorite) {
                                  await ref
                                      .read(favoriteProvider.notifier)
                                      .removeFavorite(product.id);
                                  return;
                                }

                                await ref
                                    .read(favoriteProvider.notifier)
                                    .addFavorite(
                                      Favorite(
                                        productId: product.id,
                                        name: product.name,
                                        image: product.image,
                                        price: product.price,
                                      ),
                                    );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// PRODUCT NAME
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 2),

                    /// PRICE
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TK ${product.price}",
                            style: const TextStyle(fontSize: 15),
                          ),
                          IconButton(
                            onPressed: () async {
                              await ref
                                  .read(cartProvider.notifier)
                                  .addToCart(
                                    Cart(
                                      productId: product.id,
                                      name: product.name,
                                      image: product.image,
                                      price: product.price,
                                    ),
                                  );
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Added to Cart 🛒"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            icon: const Icon(Icons.shopping_cart),
                          ),
                        ],
                      ),
                    ),
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
