import 'package:ai_powered_e_commerce_app/presentation/bottom_bar/custom_bottom_bar_shape.dart';
import 'package:ai_powered_e_commerce_app/presentation/favorite/favorite_page.dart';
import 'package:ai_powered_e_commerce_app/presentation/search/search_feild.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Curved background
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 70),
            painter: CurvedBottomBarPainter(),
          ),

          // Icons
          Positioned(
            bottom: 20,
            left: 40,
            child: IconButton(
              icon: Icon(Icons.search),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchFeild()),
                );
              },
            ),
          ),
          Positioned(
            bottom: 20,
            right: 40,
            child: IconButton(
              icon: Icon(Icons.favorite_border),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritePage()),
                );
              },
            ),
          ),

          // Center Button
          Positioned(
            top: 0,
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.tune, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
