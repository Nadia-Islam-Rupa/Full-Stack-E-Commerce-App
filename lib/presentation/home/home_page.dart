import 'package:ai_powered_e_commerce_app/presentation/cart/cart_page.dart';
import 'package:ai_powered_e_commerce_app/presentation/featured_products/product_page.dart';
import 'package:ai_powered_e_commerce_app/presentation/home/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_powered_e_commerce_app/presentation/bottom_bar/bottom_bar.dart';
import 'package:ai_powered_e_commerce_app/presentation/home/banner.dart';
import 'package:ai_powered_e_commerce_app/presentation/home/category.dart';

import 'package:ai_powered_e_commerce_app/data/banner/banner_data.dart';

import '../category/provider/category_provider.dart';
import '../featured_products/provider/featured_product_provider.dart';
import '../sub_cat/sub_category.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoryProvider);
    final featuredAsync = ref.watch(featuredProductProvider);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomBar(),
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello", style: TextStyle(fontSize: 17)),
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart, size: 28),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// SEARCH
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for products",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CATEGORY HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/categories');
                  },
                  child: const Text(
                    "view all →",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// CATEGORY LIST
            SizedBox(
              height: 90,
              child: categoryAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (categories) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SubCategoryPage(
                                categoryId: categories[index].id,
                                title: categories[index].name,
                              ),
                            ),
                          );
                        },
                        child: CategoryItem(category: categories[index]),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// BANNER
            BannerSlider(banners: bannerImages),

            const SizedBox(height: 20),

            /// FEATURED HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Featured",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductPage(
                          subCategoryId: null,
                          title: 'All Products',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "view all →",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// FEATURED PRODUCTS (RANDOM)
            SizedBox(
              height: 220,
              child: featuredAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
                data: (products) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
