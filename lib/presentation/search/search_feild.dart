import 'package:ai_powered_e_commerce_app/presentation/search/search_page.dart';
import 'package:ai_powered_e_commerce_app/presentation/search/search_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFeild extends ConsumerStatefulWidget {
  const SearchFeild({super.key});

  @override
  ConsumerState<SearchFeild> createState() => _SearchFeildState();
}

class _SearchFeildState extends ConsumerState<SearchFeild> {
  final TextEditingController controller = TextEditingController();
  String query = "";

  @override
  Widget build(BuildContext context) {
    final suggestions = ref.watch(suggestionProvider(query));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 239, 239),
        title: const Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
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
              child: TextField(
                controller: controller,

                /// when user types
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },

                /// when user presses enter
                onSubmitted: (value) {
                  if (value.trim().isEmpty) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchPage(query: value.trim()),
                    ),
                  );

                  /// clear after search
                  controller.clear();
                  setState(() {
                    query = "";
                  });
                },

                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for products",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          /// SUGGESTIONS LIST
          suggestions.when(
            loading: () => const SizedBox(),
            error: (e, _) => const SizedBox(),
            data: (products) {
              if (products.isEmpty) return const SizedBox();

              return Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return ListTile(
                      leading: Image.network(
                        product.image,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),

                      /// tap suggestion
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchPage(query: product.name),
                          ),
                        );

                        controller.clear();
                        setState(() {
                          query = "";
                        });
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
