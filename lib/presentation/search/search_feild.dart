import 'package:ai_powered_e_commerce_app/presentation/search/search_page.dart';
import 'package:flutter/material.dart';

class SearchFeild extends StatelessWidget {
  const SearchFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 239, 239),
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            onSubmitted: (value) {
              if (value.trim().isEmpty) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchPage(query: value.trim()),
                ),
              );
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search for products",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
