import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/classes/setup_button.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final FirebaseAuthentication auth;
  final String email;

  ForgotPasswordScreen({@required this.auth, this.email = ''});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _validEmail = null;
  TextEditingController _emailController = TextEditingController();

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

  @override
  Widget initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter your email address.\nWe will send you a password reset link.',
                style: TextStyle(fontFamily: 'Gilroy', fontSize: 18.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _emailController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(
                      color: kSubTitleColor, fontFamily: 'Gilroy-Bold'),
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
                      widget.auth
                          .forgotPassword(_emailController.text)
                          .then((msg) {
                        Fluttertoast.showToast(msg: msg);
                        Navigator.pop(context, _emailController.text);
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'Invalid Email.');
                    }
                  });
                },
              ),
              SizedBox(height: 50.0),
              SetupButton(
                title: 'Send',
                onPressed: () {
                  setState(() {
                    _validEmail =
                        EmailValidator.validate(_emailController.text);
                    if (_validEmail) {
                      widget.auth
                          .forgotPassword(_emailController.text)
                          .then((msg) {
                        Fluttertoast.showToast(msg: msg);
                        Navigator.pop(context, _emailController.text);
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'Invalid Email.');
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
