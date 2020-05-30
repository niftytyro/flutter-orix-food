import 'package:flutter/material.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/classes/setup_button.dart';
import 'package:orix_food_delivery/constants.dart';

class TextBox extends StatelessWidget {
  final List text;
  final bool isLast;
  final AuthScreenArguments argsObj;
  final Function onPressed;

  TextBox(
      {@required this.text,
      @required this.isLast,
      @required this.argsObj,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.325,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                text[0],
                style: kIntroHeader,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                text[1],
                style: kIntroDescription,
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: SetupButton(
              title: isLast ? 'Let\'s Eat' : 'Skip',
              onPressed: onPressed,
            ),
          )
        ],
      ),
    );
  }
}
