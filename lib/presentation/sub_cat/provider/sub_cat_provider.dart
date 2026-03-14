import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/sub_category/sub_cat_model.dart';
import '../../../data/sub_category/sub_cat_repository.dart';

final subCategoryRepositoryProvider = Provider((ref) {
  return SubCategoryRepository(Supabase.instance.client);
});

final subCategoryProvider = FutureProvider.family<List<SubCategory>, String>((
  ref,
  categoryId,
) {
  final repo = ref.watch(subCategoryRepositoryProvider);
  return repo.fetchSubCategories(categoryId);
});
