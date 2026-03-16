import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/featued_product/product_model.dart';

final searchProductProvider = FutureProvider.family<List<Product>, String>((
  ref,
  query,
) async {
  final client = Supabase.instance.client;

  if (query.isEmpty) {
    return [];
  }

  final response = await client
      .from('products')
      .select()
      .ilike('name', '%$query%');

  return (response as List).map((e) => Product.fromJson(e)).toList();
});
