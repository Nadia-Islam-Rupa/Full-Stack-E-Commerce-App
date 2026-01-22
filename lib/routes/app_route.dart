import 'package:ai_powered_e_commerce_app/data/category/category_model.dart';
import 'package:ai_powered_e_commerce_app/pages/category/caterory_page.dart';
import 'package:ai_powered_e_commerce_app/pages/category/product_list.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_powered_e_commerce_app/pages/home/home_page.dart';

class AppRoutes {
  static const home = '/';
  static const categories = '/categories';
  static const products = '/products';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: AppRoutes.categories,
      builder: (context, state) => const CategoryPage(),
    ),

    GoRoute(
      path: AppRoutes.products,
      builder: (context, state) {
        final category = state.extra as Category;
        return ProductListPage(category: category);
      },
    ),
  ],
);
