import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final String url;

  BackgroundContainer({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      scale: 0.75,
    );
  }
}
