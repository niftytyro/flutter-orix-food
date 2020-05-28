import 'package:flutter/material.dart';
import 'package:orix_food_delivery/constants.dart';

class BrandLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Image.asset('resources/images/Orix Logo.png'),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.red[200],
              offset: Offset(0.0, 15.0),
              blurRadius: 80.0,
              spreadRadius: -15.0,
            ),
          ]),
        ),
        SizedBox(height: 20.0),
        Text(
          'Orix Food',
          style: kLogoHeader,
        ),
        SizedBox(height: 5.0),
        Text(
          'Delivery App',
          style: kLogoSubTitle,
        )
      ],
    );
  }
}
