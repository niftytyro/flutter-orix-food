import 'logo_painter.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:orix_food_delivery/classes/setup_button.dart';
import 'package:orix_food_delivery/screens/login/Login.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _index = 0;
  final List _foodRow = <Image>[
    Image.asset('resources/images/welcome_icons/burger1', scale: 2.25),
    Image.asset('resources/images/welcome_icons/carrot.png', scale: 2.25),
    Image.asset('resources/images/welcome_icons/pizza-slice1.png', scale: 2.25),
    Image.asset('resources/images/welcome_icons/doughnut1.png', scale: 2.25),
    Image.asset('resources/images/welcome_icons/croissant.png', scale: 2.25),
  ];
  final List _backgroundImages = <String>[
    'resources/images/welcome_icons/chef.png',
    'resources/images/welcome_icons/meditation.png',
    'resources/images/welcome_icons/delivery.png',
  ];
  final List introText = <List>[
    [
      'Best Chefs = Best Food.',
      'Good chefs who enjoy cooking good food for good customers like you.'
    ],
    [
      'Order & Let\'s eat Healthy Food',
      'Ask not what you can do for your country. Ask what\s for lunch.'
    ],
    [
      '2 minutes Maggi?',
      'Why spend 2 minutes to cook maggi? Spend 2 minutes to order delicious food on Orix.'
    ],
  ];
  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    AuthScreenArguments argsObj = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < 0) {
            _carouselController.nextPage();
          }
          if (details.delta.dx > 0) {
            _carouselController.previousPage();
          }
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              LogoBorder(),
              Center(
                child: Column(
                  children: <Widget>[
                    CarouselSlider(
                      carouselController: _carouselController,
                      items: _backgroundImages
                          .map((urlString) =>
                              BackgroundContainer(url: urlString))
                          .toList(),
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        aspectRatio: 1.5,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _index = index;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.1 * MediaQuery.of(context).size.width),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _foodRow,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _backgroundImages.map((e) {
                        bool current = _backgroundImages.indexOf(e) == _index;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          width: current ? 20 : 10,
                          height: 5,
                          decoration: BoxDecoration(
                              color: current
                                  ? Color(0xEAFFFFFF)
                                  : Color(0x77FFFFFF),
                              borderRadius: BorderRadius.circular(10.0)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextBox(
                  text: introText[_index],
                  isLast: _index == _backgroundImages.length - 1,
                  argsObj: argsObj,
                ),
              ),
            ]),
      ),
    );
  }
}

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

class TextBox extends StatelessWidget {
  final List text;
  final bool isLast;
  final AuthScreenArguments argsObj;

  TextBox({@required this.text, @required this.isLast, @required this.argsObj});

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
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.id, (route) => false,
                    arguments: argsObj);
              },
            ),
          )
        ],
      ),
    );
  }
}
