import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/featued_product/product_model.dart';

final featuredProductProvider = FutureProvider<List<Product>>((ref) async {
  final client = Supabase.instance.client;

  final response = await client.from('products').select();

  final products = (response as List).map((e) => Product.fromJson(e)).toList();

  // shuffle list
  products.shuffle(Random());

  // return 4 random products
  return products.take(4).toList();
});
