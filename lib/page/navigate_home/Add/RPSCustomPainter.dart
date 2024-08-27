import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, 0),
        Offset(size.width * 0.50, size.height * 1.00),
        [Color(0xff5bf03d), Color(0xff11376e)],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width * 0.5000000, size.height * 0.9985714);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width, size.height * 0.1564286, size.width,
        size.height * 0.2085714);
    path0.cubicTo(
        size.width * 0.8331250,
        size.height * 0.5014286,
        size.width * 0.5835417,
        size.height * 0.4285714,
        size.width * 0.4991667,
        size.height * 0.7857143);
    path0.cubicTo(
        size.width * 0.4160417,
        size.height * 0.4267857,
        size.width * 0.1647917,
        size.height * 0.4975000,
        0,
        size.height * 0.2128571);
    path0.quadraticBezierTo(0, size.height * 0.1596429, 0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
