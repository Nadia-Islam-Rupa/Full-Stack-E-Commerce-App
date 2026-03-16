import 'package:ai_powered_e_commerce_app/data/Favorite/favorite_model.dart';
import 'package:ai_powered_e_commerce_app/data/add_cart/cart_model.dart';
import 'package:ai_powered_e_commerce_app/presentation/cart/cart_provider.dart';
import 'package:ai_powered_e_commerce_app/presentation/favorite/fav_provider.dart';
import 'package:ai_powered_e_commerce_app/data/featued_product/product_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);

    final isFavorite = favorites.any(
      (favorite) => favorite.productId == product.id,
    );

    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE + HEART
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: Image.network(product.image, fit: BoxFit.cover),
                ),
              ),

              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black,
                      size: 18,
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),

          const SizedBox(height: 4),

          /// PRICE + CART
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TK ${product.price}",
                  style: const TextStyle(fontSize: 14),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart, size: 20),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
