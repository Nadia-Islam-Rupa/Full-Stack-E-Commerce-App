import 'package:flutter/material.dart';

class CurvedBottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, 20);

    // Left curve
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.4, 0);

    // Center dip (for FAB)
    path.quadraticBezierTo(size.width * 0.5, 40, size.width * 0.6, 0);

    // Right curve
    path.quadraticBezierTo(size.width * 0.75, 0, size.width, 20);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
