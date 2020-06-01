import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          'No new notifications here.',
          style: TextStyle(
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w700,
              fontSize: 22.0),
        ),
      ),
    );
  }
}

// child: Text(
//   'No new notifications here.',
//   style: TextStyle(
//       fontFamily: 'Gilroy',
//       fontWeight: FontWeight.w700,
//       fontSize: 22.0),
