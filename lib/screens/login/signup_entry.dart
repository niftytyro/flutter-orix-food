import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orix_food_delivery/classes/screen_arguments.dart';
import 'package:orix_food_delivery/classes/setup_button.dart';
import 'package:orix_food_delivery/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orix_food_delivery/screens/home/Home.dart';
import 'package:orix_food_delivery/services/firebase_auth.dart';
import 'package:orix_food_delivery/services/firebase_firestore.dart';

enum Gender { male, female }

class SignupEntry extends StatefulWidget {
  final FirebaseAuthentication auth;
  final FirestoreDB firestoreDB;

  SignupEntry({this.auth, this.firestoreDB});

  @override
  _SignupEntryState createState() => _SignupEntryState();
}

class _SignupEntryState extends State<SignupEntry> {
  bool _validEmail = null;
  bool _showPassword = false;
  final _passwordFieldFocusNode = FocusNode();
  final _emailFieldFocusNode = FocusNode();
  Gender _selectedGender = null;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              textCapitalization: TextCapitalization.words,
              controller: _nameController,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle:
                    TextStyle(color: kSubTitleColor, fontFamily: 'Gilroy-Bold'),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[200])),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kSecondaryColor)),
              ),
              style: TextStyle(color: kDarkBlack, fontFamily: 'Gilroy'),
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              cursorColor: kSecondaryColor,
              textInputAction: TextInputAction.next,
              onSubmitted: (String name) {
                setState(() {
                  if (name.length > 0) {
                    _emailFieldFocusNode.requestFocus();
                  }
                });
              },
            ),
            TextField(
              focusNode: _emailFieldFocusNode,
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
                    _passwordFieldFocusNode.requestFocus();
                  }
                });
              },
            ),
            SizedBox(height: 15.0),
            TextField(
              focusNode: _passwordFieldFocusNode,
              obscureText: !_showPassword,
              controller: _passwordController,
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
                  _passwordFieldFocusNode.unfocus();
                }
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Gender:',
                    style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 16.0),
                  ),
                  Container(
                    width: 130.0,
                    margin: EdgeInsets.only(right: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = Gender.female;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: _selectedGender == Gender.female
                                  ? Colors.red[100]
                                  : kPrimaryColor,
                            ),
                            child: Icon(
                              FontAwesomeIcons.venus,
                              size: 35.0,
                              color: Colors.red[400],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = Gender.male;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: _selectedGender == Gender.male
                                    ? Colors.blue[100]
                                    : kPrimaryColor,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Icon(
                              FontAwesomeIcons.mars,
                              size: 35.0,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: SetupButton(
                    title: 'Sign up',
                    onPressed: () async {
                      setState(() {
                        _validEmail =
                            EmailValidator.validate(_emailController.text);
                      });
                      if ((_validEmail) &&
                          (_passwordController.text.length > 6) &&
                          (_nameController.text.length > 0) &&
                          (_selectedGender != null)) {
                        String uid = await widget.auth.signUp(
                            email: _emailController.text,
                            password: _emailController.text);
                        widget.firestoreDB.addUser(
                            email: _emailController.text,
                            name: _nameController.text,
                            gender: _selectedGender == Gender.female
                                ? 'female'
                                : 'male');
                        if (uid != null) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.id, (route) => false,
                              arguments: AuthScreenArguments(
                                  auth: widget.auth,
                                  firestoreDB: widget.firestoreDB));
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Some error occurred. Please try again.');
                        }
                      } else if (_nameController.text.length == 0) {
                        Fluttertoast.showToast(msg: 'Please enter a name.');
                      } else if (!_validEmail) {
                        Fluttertoast.showToast(msg: 'Invalid email.');
                      } else if (_passwordController.text.length < 6) {
                        Fluttertoast.showToast(msg: 'Password is too short!');
                      } else if (_selectedGender == null) {
                        Fluttertoast.showToast(msg: 'Please select a gender.');
                      }
                    })),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFieldFocusNode.dispose();
    _passwordFieldFocusNode.dispose();
    super.dispose();
  }
}
