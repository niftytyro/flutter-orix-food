import 'package:flutter/material.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/screens/home/search_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: kSecondaryColor,
                    ),
                    width: 60.0,
                    height: 60.0,
                    child: Image.asset('resources/images/profile_icon.png')),
              ),
              SizedBox(
                height: 0.05 * MediaQuery.of(context).size.height,
              ),
              Container(
                width: 0.6 * MediaQuery.of(context).size.width,
                height: 0.1 * MediaQuery.of(context).size.height,
                child: Text(
                  'Let\'s eat Quality food.',
                  style: kIntroHeader,
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(
                height: 0.05 * MediaQuery.of(context).size.height,
              ),
              SearchWidget(
                onSubmitted: (String searchTerm) {},
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
        Container(
          child: FilterChipRow(),
        )
      ],
    );
  }
}

class FilterChipRow extends StatefulWidget {
  @override
  _FilterChipRowState createState() => _FilterChipRowState();
}

class _FilterChipRowState extends State<FilterChipRow> {
  int _index = 0;

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
                  _index = 0;
                });
              }),
          FilterChip(
            selected: _index == 1,
            icon: Image.asset('resources/images/welcome_icons/doughnut2.png'),
            title: 'Sweet',
            onTap: () {
              setState(() {
                _index = 1;
              });
            },
          ),
          FilterChip(
            selected: _index == 2,
            icon: Image.asset('resources/images/welcome_icons/carrot.png'),
            title: 'Veg',
            onTap: () {
              setState(() {
                _index = 2;
              });
            },
          ),
          FilterChip(
            selected: _index == 3,
            icon: Image.asset('resources/images/welcome_icons/meat.png'),
            title: 'Non Veg',
            onTap: () {
              setState(() {
                _index = 3;
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
