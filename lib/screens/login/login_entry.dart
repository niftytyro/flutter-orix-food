import 'forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/classes/setup_button.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:orix_food_delivery/screens/home/Home.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginEntry extends StatefulWidget {
  final FirebaseAuthentication auth;
  final FirestoreDB firestoreDB;

  LoginEntry({this.auth, this.firestoreDB});

  @override
  _LoginEntryState createState() => _LoginEntryState();
}

class _LoginEntryState extends State<LoginEntry> {
  bool _validEmail = null;
  bool _showPassword = false;
  final _nextFieldFocusNode = FocusNode();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Widget getEmailSuffix() {
    if (_validEmail == null) {
      return null;
    }
    return _validEmail
        ? Icon(Icons.check, color: kSecondaryColor)
        : Icon(
            Icons.clear,
            color: Colors.red[600],
          );
  }

  Widget getPasswordSuffix() {
    return IconButton(
      onPressed: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
      icon: _showPassword
          ? Icon(Icons.visibility, color: kSecondaryColor)
          : Icon(Icons.visibility_off, color: kSubTitleColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      color: kPrimaryColor,
      child: Column(
        children: <Widget>[
          TextField(
            controller: _emailController,
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Email Address',
              labelStyle:
                  TextStyle(color: kSubTitleColor, fontFamily: 'Gilroy-Bold'),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[200])),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kSecondaryColor)),
              suffixIcon: getEmailSuffix(),
            ),
            style: TextStyle(color: kDarkBlack, fontFamily: 'Gilroy'),
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            cursorColor: kSecondaryColor,
            textInputAction: TextInputAction.next,
            onSubmitted: (String email) {
              setState(() {
                _validEmail = EmailValidator.validate(email);
                if (_validEmail) {
                  _nextFieldFocusNode.requestFocus();
                }
              });
            },
          ),
          SizedBox(height: 15.0),
          TextField(
            controller: _passwordController,
            focusNode: _nextFieldFocusNode,
            obscureText: !_showPassword,
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle:
                  TextStyle(color: kSubTitleColor, fontFamily: 'Gilroy-Bold'),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[200])),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kSecondaryColor)),
              suffixIcon: getPasswordSuffix(),
            ),
            style: TextStyle(color: kDarkBlack, fontFamily: 'Gilroy'),
            keyboardType: TextInputType.visiblePassword,
            maxLines: 1,
            cursorColor: kSecondaryColor,
            onSubmitted: (String pass) {
              if (pass.length > 8) {
                _nextFieldFocusNode.unfocus();
              }
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () async {
                _emailController.text = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(
                      email: _emailController.text,
                      auth: widget.auth,
                    ),
                  ),
                );
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    color: kSubTitleColor,
                    fontFamily: 'Gilroy-Bold',
                    fontSize: 10.0),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          SetupButton(
            title: 'Login',
            onPressed: () async {
              setState(() {
                _validEmail = EmailValidator.validate(_emailController.text);
              });
              if ((_validEmail) && (_passwordController.text.length > 6)) {
                String uid = await widget.auth.signIn(
                    email: _emailController.text,
                    password: _emailController.text);
                if (uid != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false,
                      arguments: AuthScreenArguments(
                          auth: widget.auth, firestoreDB: widget.firestoreDB));
                } else {
                  Fluttertoast.showToast(
                      msg: 'Some error occurred. Please try again.');
                }
              } else if (!_validEmail) {
                Fluttertoast.showToast(msg: 'Invalid email.');
              } else if (_passwordController.text.length < 6) {
                Fluttertoast.showToast(msg: 'Password is too short!');
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nextFieldFocusNode.dispose();
    super.dispose();
  }
}
