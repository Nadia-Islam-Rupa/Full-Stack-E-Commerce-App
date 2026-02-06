import 'package:supabase_flutter/supabase_flutter.dart';
import 'category_model.dart';

class CategoryRepository {
  final SupabaseClient _client;

  CategoryRepository(this._client);

  Future<List<Category>> fetchCategories() async {
    final response = await _client
        .from('category')
        .select()
        .order('created_at');

    return response.map<Category>((e) => Category.fromJson(e)).toList();
  }
}
