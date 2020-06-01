import 'package:flutter/material.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/screens/home/home_view/selected_tag.dart';

class FilterChipRow extends StatefulWidget {
  final SelectedTag tagObj;
  final Function onTap;

  FilterChipRow({@required this.tagObj, @required this.onTap});

  @override
  _FilterChipRowState createState() => _FilterChipRowState();
}

class _FilterChipRowState extends State<FilterChipRow> {
  int _index;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30.0,
          ),
          FilterChip(
              selected: _index == 0,
              icon: Image.asset('resources/images/welcome_icons/burger2.png'),
              title: 'Fast food',
              onTap: () {
                setState(() {
                  widget.tagObj.setTag('fast food');
                  _index = 0;
                  widget.onTap();
                });
              }),
          FilterChip(
            selected: _index == 1,
            icon: Image.asset('resources/images/welcome_icons/doughnut2.png'),
            title: 'Sweet',
            onTap: () {
              setState(() {
                widget.tagObj.setTag('sweet');
                _index = 1;
                widget.onTap();
              });
            },
          ),
          FilterChip(
            selected: _index == 2,
            icon: Image.asset('resources/images/welcome_icons/carrot.png'),
            title: 'Veg',
            onTap: () {
              setState(() {
                widget.tagObj.setTag('veg');
                _index = 2;
                widget.onTap();
              });
            },
          ),
          FilterChip(
            selected: _index == 3,
            icon: Image.asset('resources/images/welcome_icons/meat.png'),
            title: 'Non Veg',
            onTap: () {
              setState(() {
                widget.tagObj.setTag('non veg');
                _index = 3;
                widget.onTap();
              });
            },
          ),
        ],
      ),
    );
  }
}

class FilterChip extends StatelessWidget {
  final bool selected;
  final Image icon;
  final String title;
  final Function onTap;
  FilterChip(
      {@required this.selected,
      @required this.icon,
      @required this.title,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 25.0),
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: selected ? kSecondaryColor : kPrimaryColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: kSecondaryColor, width: 0.5),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 60.0,
              height: 60.0,
              child: FittedBox(
                child: icon,
              ),
            ),
            Text(
              title,
              style: kChipFilterStyle,
            ),
          ],
        ),
      ),
    );
  }
}
