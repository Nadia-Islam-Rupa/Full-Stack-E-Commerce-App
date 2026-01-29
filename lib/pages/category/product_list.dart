import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('category.name')),
      body: Center(
        child: Text("Products of", style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
