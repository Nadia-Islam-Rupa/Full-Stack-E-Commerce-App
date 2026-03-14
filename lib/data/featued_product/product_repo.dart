import 'package:supabase_flutter/supabase_flutter.dart';
import 'product_model.dart';

class ProductRepository {
  final SupabaseClient _client;

  ProductRepository(this._client);

  Future<List<Product>> fetchProducts(String subCategoryId) async {
    final response = await _client
        .from('products')
        .select()
        .eq('sub_category_id', subCategoryId);

    return response.map<Product>((e) => Product.fromJson(e)).toList();
  }
}
