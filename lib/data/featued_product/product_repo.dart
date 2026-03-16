import 'package:supabase_flutter/supabase_flutter.dart';
import 'product_model.dart';

class ProductRepository {
  final SupabaseClient _client;

  ProductRepository(this._client);

  Future<List<Product>> fetchProducts([String? subCategoryId]) async {
    var query = _client.from('products').select();

    if (subCategoryId != null) {
      query = query.eq('sub_category_id', subCategoryId);
    }

    final response = await query;

    return response.map<Product>((e) => Product.fromJson(e)).toList();
  }
}
