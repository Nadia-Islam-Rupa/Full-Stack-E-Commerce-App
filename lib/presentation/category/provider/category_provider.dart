import 'package:ai_powered_e_commerce_app/data/category/category_repository.dart';
import 'package:ai_powered_e_commerce_app/data/category/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase client provider
final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Repository provider
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final client = ref.watch(supabaseProvider);
  return CategoryRepository(client);
});

/// Category list provider
final categoryProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.fetchCategories();
});
