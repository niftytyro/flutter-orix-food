import 'package:flutter/material.dart';
import 'package:orix_food_delivery/constants.dart';

class SetupButton extends StatelessWidget {
  final Color _backgroundColor = kSecondaryColor;
  final String title;
  final onPressed;

  SetupButton({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50.0,
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: kButtonTitleStyle,
        ),
        color: _backgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
