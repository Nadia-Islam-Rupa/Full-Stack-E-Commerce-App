import 'package:ai_powered_e_commerce_app/data/banner/banner_data.dart';
import 'package:ai_powered_e_commerce_app/data/category/category_data.dart';

import 'package:ai_powered_e_commerce_app/data/featued_product/featured_data.dart';
import 'package:ai_powered_e_commerce_app/presentation/bottom_bar/bottom_bar.dart';
import 'package:ai_powered_e_commerce_app/presentation/home/banner.dart';
import 'package:ai_powered_e_commerce_app/presentation/home/category.dart';
import 'package:ai_powered_e_commerce_app/presentation/home/featured_product.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomBar(),

      backgroundColor: const Color.fromARGB(255, 240, 239, 239),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 110),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart, size: 28),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),

                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for products",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/categories');
                  },
                  child: Text(
                    "view all ->",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CategoryItem(category: categories[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            BannerSlider(banners: bannerImages),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "view all ->",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: featuredProducts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
