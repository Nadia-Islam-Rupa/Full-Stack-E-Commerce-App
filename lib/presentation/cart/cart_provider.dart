import 'package:ai_powered_e_commerce_app/data/add_cart/cart_model.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

final cartProvider = StateNotifierProvider<CartController, List<Cart>>((ref) {
  return CartController();
});

class CartController extends StateNotifier<List<Cart>> {
  CartController() : super([]) {
    loadCart();
  }

  Future<void> loadCart() async {
    final data = await supabase.from('cart').select();

    state = data.map<Cart>((e) {
      return Cart(
        productId: e['product_id'],
        name: e['name'],
        image: e['image'],
        price: (e['price'] as num).toDouble(),
      );
    }).toList();
  }

  Future<void> addToCart(Cart item) async {
    await supabase.from('cart').insert(item.toJson());
    await loadCart();
  }

  Future<void> removeCart(String productId) async {
    await supabase.from('cart').delete().eq('product_id', productId);
    await loadCart();
  }
}
