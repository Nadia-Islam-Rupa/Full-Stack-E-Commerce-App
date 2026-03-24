# E-Commerce App

A Flutter e-commerce application with Supabase backend, Riverpod state management, and a clean multi-screen shopping flow.

## Quick Snapshot

| Item                 | Value                                                        |
| -------------------- | ------------------------------------------------------------ |
| Platform             | Flutter (Android, iOS, Web, Desktop-ready project structure) |
| State Management     | Riverpod                                                     |
| Backend              | Supabase                                                     |
| Navigation           | GoRouter + Navigator (mixed)                                 |
| Current Focus        | Catalog, search, favorites, cart                             |
| Missing Core Modules | Auth, checkout, orders, AI recommendation engine             |

## Table of Contents

1. [Project Overview](#project-overview)
2. [Features](#features)
3. [User Guide](#user-guide)
4. [System Documentation](#system-documentation)
5. [Data and Supabase Schema](#data-and-supabase-schema)
6. [Setup and Run](#setup-and-run)
7. [Testing and Quality](#testing-and-quality)
8. [Current Gaps and Risks](#current-gaps-and-risks)
9. [Roadmap](#roadmap)

## Project Overview

### Goal

This project implements the core shopping journey:

1. Browse categories and sub-categories
2. Discover products
3. Search with suggestions
4. Save favorites
5. Add/remove cart items

### Reality Check

The repository name says "AI Powered", but the current codebase does not yet include an AI recommendation module.

## Features

### Implemented

1. Home screen with:
   - Category preview
   - Banner carousel
   - Featured products
2. Category list and sub-category navigation
3. Product listing (all products or filtered by sub-category)
4. Search and instant suggestions
5. Favorites CRUD via Supabase
6. Cart CRUD via Supabase
7. Custom curved bottom bar UI

### Not Implemented Yet

1. User authentication
2. User-scoped data (cart/favorites per user)
3. Checkout and payment
4. Order history and profile pages
5. AI recommendation/personalization

## User Guide

### 1. Home Screen

1. Launch app and land on Home.
2. Browse category row, banner, and featured product cards.
3. Tap cart icon (top-right) to open cart.

### 2. Category Browsing

1. Tap `view all ->` in the Categories section.
2. Select a category.
3. Select a sub-category.
4. View products for that sub-category.

### 3. Product Actions

On any product card:

1. Tap heart icon to add/remove favorite.
2. Tap cart icon to add item to cart.

### 4. Search

1. Use the Home search box for direct search.
2. Or tap the search icon in bottom bar.
3. Type product name to get suggestions.
4. Press Enter or tap a suggestion to open results.

### 5. Favorites

1. Open favorites from bottom bar (right icon).
2. Remove items with delete icon.
3. "Add to Cart" on favorites currently shows a message only.

### 6. Cart

1. Open cart from Home header cart icon.
2. Remove items with delete icon.
3. `Order Now` button is currently UI-only.

## System Documentation

### Architecture

```text
Presentation Layer (screens/widgets)
  -> Riverpod Providers
    -> Repository Layer
      -> Supabase Tables

Data Models map JSON/DB fields to Dart types.
```

### Project Structure

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
      featured_model.dart        (legacy/unused)
      featured_data.dart         (legacy/unused)
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
    log_in/                      (empty)
    search/
    sub_cat/
```

### Key Screens and Responsibilities

| Screen        | Path                                                   | Responsibility                                           |
| ------------- | ------------------------------------------------------ | -------------------------------------------------------- |
| Home          | `lib/presentation/home/home_page.dart`                 | Entry UI, category preview, featured strip, quick search |
| Category      | `lib/presentation/category/caterory_page.dart`         | Category grid                                            |
| Sub-category  | `lib/presentation/sub_cat/sub_category.dart`           | Sub-category grid by category                            |
| Product List  | `lib/presentation/featured_products/product_page.dart` | Product grid, favorite/cart actions                      |
| Search Field  | `lib/presentation/search/search_feild.dart`            | Suggestion-driven search input                           |
| Search Result | `lib/presentation/search/search_page.dart`             | Search result grid                                       |
| Favorite      | `lib/presentation/favorite/favorite_page.dart`         | Favorite list management                                 |
| Cart          | `lib/presentation/cart/cart_page.dart`                 | Cart list and remove actions                             |

### Routing

Defined in `lib/routes/app_route.dart`:

1. `/` -> `HomePage`
2. `/categories` -> `CategoryPage`

Other pages are opened using `Navigator.push`, so routing is currently mixed (`GoRouter` + `Navigator`).

### State Management Map

| Provider                          | Type                             | Purpose                      |
| --------------------------------- | -------------------------------- | ---------------------------- |
| `categoryProvider`                | `FutureProvider<List<Category>>` | Load categories              |
| `subCategoryProvider(categoryId)` | `FutureProvider.family`          | Load sub-categories          |
| `productProvider(subCategoryId)`  | `FutureProvider.family`          | Load products (all/filtered) |
| `featuredProductProvider`         | `FutureProvider<List<Product>>`  | Random featured products     |
| `searchProductProvider(query)`    | `FutureProvider.family`          | Full search                  |
| `suggestionProvider(query)`       | `FutureProvider.family`          | Prefix suggestions           |
| `favoriteProvider`                | `StateNotifierProvider`          | Favorites read/write         |
| `cartProvider`                    | `StateNotifierProvider`          | Cart read/write              |

## Data and Supabase Schema

### Required Tables

1. `category`
2. `sub_category`
3. `products`
4. `favorites`
5. `cart`

### Fields Used by Code

| Table          | Required Fields                                       |
| -------------- | ----------------------------------------------------- |
| `category`     | `id`, `name`, `image_url`, `created_at`               |
| `sub_category` | `id`, `name`, `category_id`, `image_url`              |
| `products`     | `id`, `name`, `price`, `image_url`, `sub_category_id` |
| `favorites`    | `product_id`, `name`, `image`, `price`                |
| `cart`         | `product_id`, `name`, `image`, `price`                |

### Starter SQL

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

## Setup and Run

### Prerequisites

1. Flutter SDK installed
2. Supabase project with required tables
3. Android Studio or VS Code Flutter tooling

### Install

```bash
flutter pub get
```

### Run

```bash
flutter run
```

### Build

```bash
flutter build apk
flutter build ios
flutter build web
```

### Environment and Secrets

Current code uses hardcoded Supabase URL and anon key in `lib/main.dart`.

Recommended:

```bash
flutter run \
  --dart-define=SUPABASE_URL=your_url \
  --dart-define=SUPABASE_ANON_KEY=your_anon_key
```

Then read these values in code instead of hardcoded strings.

## Testing and Quality

### Static Analysis

- No analyzer errors were reported in the latest check.

### Test Status

- Existing `test/widget_test.dart` is the default counter test and does not match this app.
- The test run currently fails due to `ProviderScope` issues and outdated expectations.

## Current Gaps and Risks

1. Hardcoded Supabase credentials in source
2. No authentication and no user-specific data boundaries
3. Mixed routing strategy (`GoRouter` and `Navigator`)
4. Naming inconsistencies:
   - `caterory_page.dart`
   - `search_feild.dart`
   - `featued_product/`
5. Legacy Riverpod import usage in some files (`flutter_riverpod/legacy.dart`)
6. Unused items:
   - `shared_preferences` dependency
   - `lib/data/featued_product/featured_model.dart`
   - `lib/data/featued_product/featured_data.dart`
7. `lib/presentation/log_in/` exists but is empty
8. Favorites page "Add to Cart" action does not write to cart table yet

## Roadmap

1. Move Supabase credentials to environment config
2. Add authentication + row level security
3. Refactor navigation to one consistent pattern
4. Clean naming and remove legacy/unused modules
5. Add widget/integration tests for all major flows
6. Implement checkout and order management
7. Add AI recommendation features

## Assets

Configured under `assets/` and used in banners and UI:

1. `assets/fashion.jpg`
2. `assets/beauty.webp`
3. `assets/kids.webp`
4. `assets/men.jpeg`
5. `assets/women.png`

---

For maintainers: the fastest path to production readiness is `security -> auth -> tests -> checkout`.
