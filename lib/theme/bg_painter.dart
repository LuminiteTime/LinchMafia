import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final ThemeMode themeMode = ThemeMode.dark;

  BackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          themeMode == ThemeMode.dark ? Colors.black : Colors.grey[850]!,
          const Color.fromARGB(255, 60, 60, 60),
          const Color.fromARGB(255, 30, 30, 30),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    final Paint accentPaint = Paint()
      ..color = const Color.fromARGB(255, 145, 45, 45).withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.3), 100, accentPaint);
    canvas.drawCircle(
        Offset(size.width * 0.2, size.height * 0.7), 50, accentPaint);
    canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.8), 75, accentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
