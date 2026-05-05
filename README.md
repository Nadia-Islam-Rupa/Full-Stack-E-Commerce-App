# Full-Stack E-Commerce App (Flutter + Supabase)

A Flutter e-commerce application with category browsing, product discovery, search, favorites, and cart management powered by Supabase.

## Overview

This repository contains a multi-platform Flutter app (Android, iOS, Web, Desktop folders included) with a Supabase backend and Riverpod state management.

Current implemented user flow:
1. Browse categories
2. Open sub-categories
3. View products
4. Search products with suggestions
5. Add/remove favorites
6. Add/remove cart items

The project name mentions "AI Powered", but there is currently no AI recommendation engine in the code.

## Tech Stack

- Flutter (Dart SDK constraint: `^3.10.1`)
- `flutter_riverpod` for state management
- `supabase_flutter` for backend access
- `go_router` (partially used for route navigation)

## Implemented Features

- Home page with:
  - Category preview row
  - Banner slider from local assets
  - Featured products (random 4 products)
- Category page (grid)
- Sub-category page (grid by category)
- Product page (all or filtered by sub-category)
- Product search with:
  - Instant suggestions (`name like query%`)
  - Search results (`name like %query%`)
- Favorites:
  - Insert into `favorites`
  - Delete from `favorites`
  - Read all favorites
- Cart:
  - Insert into `cart`
  - Delete from `cart`
  - Read all cart items
- Custom curved bottom navigation bar UI

## Not Implemented Yet

- Authentication and user sessions
- User-specific cart/favorites isolation
- Checkout and payment flow
- Order history
- AI personalization/recommendations

## Project Structure

```text
lib/
  main.dart
  routes/
    app_route.dart
  data/
    Favorite/
      favorite_model.dart
    add_cart/
      cart_model.dart
    banner/
      banner_data.dart
    category/
      category_model.dart
      category_repository.dart
    featued_product/
      product_model.dart
      product_repo.dart
      featured_data.dart
      featured_model.dart
    sub_category/
      sub_cat_model.dart
      sub_cat_repository.dart
  presentation/
    bottom_bar/
    cart/
    category/
    favorite/
    featured_products/
    home/
    search/
    sub_cat/
```

## Main Screens

- `HomePage`: `lib/presentation/home/home_page.dart`
- `CategoryPage`: `lib/presentation/category/caterory_page.dart`
- `SubCategoryPage`: `lib/presentation/sub_cat/sub_category.dart`
- `ProductPage`: `lib/presentation/featured_products/product_page.dart`
- `SearchFeild`: `lib/presentation/search/search_feild.dart`
- `SearchPage`: `lib/presentation/search/search_page.dart`
- `FavoritePage`: `lib/presentation/favorite/favorite_page.dart`
- `CartPage`: `lib/presentation/cart/cart_page.dart`

## Routing

`go_router` routes in `lib/routes/app_route.dart`:
- `/` -> `HomePage`
- `/categories` -> `CategoryPage`

Other navigations are handled with `Navigator.push`, so the app currently uses a mixed navigation strategy.

## State Management

Important providers:
- `categoryProvider`
- `subCategoryProvider(categoryId)`
- `productProvider(subCategoryId)`
- `featuredProductProvider`
- `searchProductProvider(query)`
- `suggestionProvider(query)`
- `favoriteProvider`
- `cartProvider`

## Supabase Tables Required

The app expects these tables:
1. `category`
2. `sub_category`
3. `products`
4. `favorites`
5. `cart`

Expected columns by current code:

- `category`: `id`, `name`, `image_url`, `created_at`
- `sub_category`: `id`, `name`, `category_id`, `image_url`
- `products`: `id`, `name`, `price`, `image_url`, `sub_category_id`
- `favorites`: `product_id`, `name`, `image`, `price`
- `cart`: `product_id`, `name`, `image`, `price`

Example SQL:

```sql
create table if not exists category (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  image_url text not null,
  created_at timestamptz not null default now()
);

create table if not exists sub_category (
  id uuid primary key default gen_random_uuid(),
  category_id uuid not null references category(id) on delete cascade,
  name text not null,
  image_url text not null
);

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  sub_category_id uuid not null references sub_category(id) on delete cascade,
  name text not null,
  price numeric not null,
  image_url text not null
);

create table if not exists favorites (
  product_id uuid primary key,
  name text not null,
  image text not null,
  price numeric not null
);

create table if not exists cart (
  product_id uuid primary key,
  name text not null,
  image text not null,
  price numeric not null
);
```

## Setup

### 1. Prerequisites

- Flutter SDK installed
- A Supabase project
- Required tables created

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run app

```bash
flutter run
```

### 4. Build

```bash
flutter build apk
flutter build ios
flutter build web
```

## Configuration Note

Supabase URL and anon key are currently hardcoded in `lib/main.dart`.

For production, move credentials to environment config (for example, `--dart-define`) and read them in code.

## Assets

Local assets in `assets/`:
- `assets/fashion.jpg`
- `assets/beauty.webp`
- `assets/kids.webp`
- `assets/men.jpeg`
- `assets/women.png`

## Known Issues / Cleanup Opportunities

- Inconsistent naming:
  - `caterory_page.dart`
  - `search_feild.dart`
  - `featued_product/`
- Mixed Riverpod imports (`flutter_riverpod` and `flutter_riverpod/legacy.dart`)
- `shared_preferences` is listed in dependencies but not used
- `featured_data.dart` and `featured_model.dart` appear unused
- Default test file does not match this app behavior
- Favorites page "Add to Cart" button currently shows only a snackbar

## Recommended Next Steps

1. Move Supabase keys out of source code
2. Add auth and row-level security
3. Make cart/favorites user-specific
4. Unify all navigation under one approach
5. Add real widget and integration tests
6. Implement checkout and order flow
7. Add AI recommendation module
