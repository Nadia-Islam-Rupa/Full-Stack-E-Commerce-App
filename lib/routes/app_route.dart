import 'package:ai_powered_e_commerce_app/data/category/category_model.dart';
import 'package:ai_powered_e_commerce_app/pages/category/caterory_page.dart';
import 'package:ai_powered_e_commerce_app/pages/category/product_list.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_powered_e_commerce_app/pages/home/home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),

    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoryPage(),
    ),

    GoRoute(
      path: '/products',
      builder: (context, state) {
        final category = state.extra as Category;
        return ProductListPage(category: category);
      },
    ),
  ],
);
