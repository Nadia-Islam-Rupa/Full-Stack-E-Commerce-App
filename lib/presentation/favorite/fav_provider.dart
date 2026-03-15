import 'package:ai_powered_e_commerce_app/data/Favorite/favorite_model.dart';

import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

final favoriteProvider =
    StateNotifierProvider<FavoriteController, List<Favorite>>((ref) {
      return FavoriteController();
    });

class FavoriteController extends StateNotifier<List<Favorite>> {
  FavoriteController() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final data = await supabase.from('favorites').select();

    state = data
        .map<Favorite>(
          (e) => Favorite(
            productId: e['product_id'],
            name: e['name'],
            image: e['image'],
            price: (e['price'] as num).toDouble(),
          ),
        )
        .toList();
  }

  Future<void> addFavorite(Favorite product) async {
    await supabase.from('favorites').insert(product.toJson());
    loadFavorites();
  }

  Future<void> removeFavorite(String productId) async {
    await supabase.from('favorites').delete().eq('product_id', productId);
    loadFavorites();
  }
}
