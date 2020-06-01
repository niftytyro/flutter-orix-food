import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orix_food_delivery/custom_icons.dart';
import 'package:orix_food_delivery/constants.dart';

class NavBarRow extends StatefulWidget {
  final List icons;

  NavBarRow({this.icons});

  @override
  _NavBarRowState createState() => _NavBarRowState();
}

class _NavBarRowState extends State<NavBarRow> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          transform: Matrix4.translationValues(0, 10.0, 0),
          width: 0.35 * MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 20.0),
          child: NavBarButton(
            iconData: widget.icons[0][0],
            onPressed: () {
              setState(() {
                _currentIndex = 0;
              });
              widget.icons[0][1]();
            },
            selected: _currentIndex == 0,
          ),
        ),
        SizedBox(width: 0.3 * MediaQuery.of(context).size.width),
        Container(
          transform: Matrix4.translationValues(0, 10.0, 0),
          width: 0.35 * MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 20.0),
          child: NavBarButton(
            iconData: widget.icons[1][0],
            onPressed: () {
              setState(() {
                _currentIndex = 3;
              });
              widget.icons[1][1]();
            },
            selected: _currentIndex == 3,
          ),
        ),
      ],
    );
  }
}

class NavBarButton extends StatefulWidget {
  final IconData iconData;
  final Function onPressed;
  final bool selected;

  NavBarButton(
      {@required this.iconData,
      @required this.onPressed,
      @required this.selected});

  @override
  _NavBarButtonState createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: widget.selected ? Color(0xFFF5F5F5) : Colors.transparent,
              blurRadius: 10.0),
        ],
      ),
      child: IconButton(
        icon: Icon(
          widget.iconData,
          color: widget.selected ? kSecondaryColor : kSubTitleColor,
          size: 30.0,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
