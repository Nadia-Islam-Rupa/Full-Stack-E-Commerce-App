import 'package:flutter/material.dart';

class CategoryName extends StatelessWidget {
  const CategoryName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(Icons.category, size: 30, color: Colors.blue),
            ),
            SizedBox(height: 5),
            Text(
              "Fashion",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
