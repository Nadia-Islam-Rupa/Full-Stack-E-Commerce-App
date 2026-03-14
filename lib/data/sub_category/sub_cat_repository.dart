import 'package:supabase_flutter/supabase_flutter.dart';

import 'sub_cat_model.dart';

class SubCategoryRepository {
  final SupabaseClient _client;

  SubCategoryRepository(this._client);

  Future<List<SubCategory>> fetchSubCategories(String categoryId) async {
    final response = await _client
        .from('sub_category')
        .select()
        .eq('category_id', categoryId);

    return response.map<SubCategory>((e) => SubCategory.fromJson(e)).toList();
  }
}
