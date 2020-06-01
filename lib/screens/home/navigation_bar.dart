import 'package:flutter/material.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/custom_icons.dart';
import 'navbar_row.dart';

class NavigationBar extends StatefulWidget {
  final List icons;

  NavigationBar({@required this.icons});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: Stack(
              children: <Widget>[
                CustomPaint(
                  painter: NavBarPainter(),
                  size: Size(MediaQuery.of(context).size.width, 60.0),
                ),
                NavBarRow(icons: widget.icons.sublist(1)),
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.icons[0][1],
            child: Container(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kSecondaryColor,
                    border: Border.all(
                        color: Color(0xFFFFFFFF),
                        width: 4,
                        style: BorderStyle.solid),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          spreadRadius: 3.0,
                          offset: Offset(0.0, 5.0))
                    ],
                  ),
                  width: 80,
                  height: 80,
                  child: Icon(
                    widget.icons[0][0],
                    size: 30.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();
    var sw = size.width;
    var sh = size.height;

    paint.color = Color(0xFFFFFFFF);
    paint.style = PaintingStyle.fill;

    path.quadraticBezierTo(0.25 * sw, -40.0, 0.35 * sw, -30.0);
    path.quadraticBezierTo(0.37 * sw, -27.0, 0.37 * sw, -20.0);
    path.quadraticBezierTo(0.4 * sw, 45.0, 0.5 * sw, 45.0);
    path.quadraticBezierTo(0.6 * sw, 45.0, 0.63 * sw, -20.0);
    path.quadraticBezierTo(0.63 * sw, -27.0, 0.65 * sw, -30.0);
    path.quadraticBezierTo(0.75 * sw, -40, sw, 0.0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
