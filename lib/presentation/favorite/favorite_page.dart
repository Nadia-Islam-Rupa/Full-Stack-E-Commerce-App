import 'package:ai_powered_e_commerce_app/presentation/favorite/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];

          return ListTile(
            leading: Image.network(item.image, width: 50),
            title: Text(item.name),
            subtitle: Text("TK ${item.price}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref
                    .read(favoriteProvider.notifier)
                    .removeFavorite(item.productId);
              },
            ),
          );
        },
      ),
    );
  }
}
