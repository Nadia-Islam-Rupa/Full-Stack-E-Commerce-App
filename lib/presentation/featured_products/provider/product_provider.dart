import 'package:ai_powered_e_commerce_app/data/featued_product/product_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/featued_product/product_model.dart';

final productRepositoryProvider = Provider((ref) {
  return ProductRepository(Supabase.instance.client);
});

final productProvider = FutureProvider.family<List<Product>, String>((
  ref,
  subCategoryId,
) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.fetchProducts(subCategoryId);
});
