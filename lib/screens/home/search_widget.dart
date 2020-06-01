import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/custom_icons.dart';

OutlineInputBorder kSearchBorder = OutlineInputBorder(
    borderSide: BorderSide(
        color: Color(0xFFFFFFFF), width: 3.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(20.0));
Color kSearchFillColor = Color(0xFFFAFAFF);
TextStyle kSearchHintStyle =
    TextStyle(fontFamily: 'Gilroy', fontSize: 15.0, color: Colors.black87);

class SearchWidget extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final Function onSubmitted;

  SearchWidget({@required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _searchController,
        autofocus: false,
        decoration: InputDecoration(
          border: kSearchBorder,
          disabledBorder: kSearchBorder,
          enabledBorder: kSearchBorder,
          errorBorder: kSearchBorder,
          focusedBorder: kSearchBorder,
          focusedErrorBorder: kSearchBorder,
          fillColor: kSearchFillColor,
          focusColor: kSearchFillColor,
          hoverColor: kSearchFillColor,
          filled: true,
          hintText: 'Search food...',
          hintStyle: kSearchHintStyle,
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: 20.0),
              Icon(
                FontAwesomeIcons.search,
                color: Colors.black87,
                size: 20.0,
              ),
              SizedBox(width: 15.0),
            ],
          ),
        ),
        cursorColor: Colors.black87,
        keyboardType: TextInputType.text,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
