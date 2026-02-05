import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestSupabasePage extends StatefulWidget {
  const TestSupabasePage({super.key});

  @override
  State<TestSupabasePage> createState() => _TestSupabasePageState();
}

class _TestSupabasePageState extends State<TestSupabasePage> {
  final supabase = Supabase.instance.client;

  List products = [];
  bool loading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final data = await supabase.from('products').select();
      setState(() {
        products = data;
        loading = false;
      });

      // Console output (VERY IMPORTANT)
      print('Supabase products: $data');
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
      print('Supabase error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Connection Test'),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
          ? Center(child: Text(error))
          : products.isEmpty
          ? const Center(
              child: Text(
                'No products found.\nBut connection is WORKING ✅',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: product['image_url'] != null
                        ? Image.network(
                            product['image_url'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image),
                    title: Text(product['name'] ?? 'No name'),
                    subtitle: Text(
                      '৳ ${product['price']} • ${product['category']}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
