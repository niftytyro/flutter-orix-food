import 'package:flutter/material.dart';
import 'package:orix_food_delivery/classes/Logo.dart';
import 'package:orix_food_delivery/constants.dart';

class LogoBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvePainter(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        height: 150,
        width: 130,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: BrandLogo(),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();

    paint.color = kPrimaryColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 3.0;

    path.lineTo(0, 180.0);
    path.quadraticBezierTo(0.0, 190.0, 65.0, 190.0);
    path.quadraticBezierTo(110.0, 205.0, 95.0, 200.0);
    path.quadraticBezierTo(145.0, 215.0, 155.0, 130.0);
    path.quadraticBezierTo(160.0, 120.0, 185.0, 90.0);
    path.quadraticBezierTo(200.0, 60.0, 185.0, 25.0);
    path.quadraticBezierTo(185.0, 15.0, 175.0, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
