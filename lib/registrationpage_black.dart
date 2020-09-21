import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:forteapp/user_profile_init.dart';
import 'package:flutter/gestures.dart';
import 'package:forteapp/login_page.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String confirmpassword;
  //bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    theme:
    ThemeData(unselectedWidgetColor: Colors.grey);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/group-5-copy-2@2x.png',
              fit: BoxFit.contain,
              height: 28,
            ),
            // Container(padding: const EdgeInsets.all(1.0),
            //    child: Text(''))
          ],
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        //title: Text("Login Page"),
        backgroundColor: Colors.black,
        elevation: 0.0,
        //backgroundColor: Colors.black87, //removed Login Page
      ),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: ListView(
            //added alignments
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Get Started ',
                              style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: Colors.white,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Are you an athlete or a coach?",
                  style: TextStyle(
                    fontFamily: 'SöhneBreitTest',
                    //fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                //mainAxisSize: MediaQuery.of(context).size.width * 0.8,
                children: <Widget>[
                  SizedBox(
                    width: 5.0,
                    height: 30.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      //color: Colors.lightBlueAccent,
                      //shape: RoundedRectangleBorder(
                      //borderRadius: BorderRadius.circular(18.0)),
                      //: BorderRadius.circular(30.0),

                      child: Text(
                        "ATHLETE",
                        style: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Color(0xFF220EE2),
                        ),
                      ),
                      color: Colors.white,
                      textColor: Color(0xFF220EE2),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                        print('NothingDoing');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      //color: Colors.lightBlueAccent,
                      //shape: RoundedRectangleBorder(
                      //borderRadius: BorderRadius.circular(18.0)),
                      //: BorderRadius.circular(30.0),

                      child: Text(
                        "COACH",
                        style: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Color(0xFF220EE2),
                        ),
                      ),
                      color: Colors.white,
                      textColor: Color(0xFF220EE2),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                        print('NothingDoing');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  style: TextStyle(
                    fontFamily: 'SöhneBreitTest',
                    //fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      // fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Colors.white,
                    ),
                  )),
              TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  style: TextStyle(
                    fontFamily: 'SöhneBreitTest',
                    //fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  obscureText: true,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      // fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Colors.white,
                    ),
                  )),
              TextFormField(
                  onChanged: (value) {
                    confirmpassword = value;
                  },
                  style: TextStyle(
                    fontFamily: 'SöhneBreitTest',
                    //fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  obscureText: true,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      // fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Colors.white,
                    ),
                  )),
              Container(
                padding: EdgeInsets.all(5.0),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: MyTermsAndConditions(),
                    )
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: RaisedButton(
                          child: Text(
                            "CREATE ACCOUNT",
                            style: TextStyle(
                              fontFamily: 'SöhneBreitTest',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Color(0xFF220EE2),
                          textColor: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Color(0xFF220EE2))),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              //print(email);
                              //print(password);
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              if (newUser != null) {
                                Navigator.pushNamed(
                                    context, UserProfileInitPage.id);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          }),
                    ),
                  ]),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: TextSpan(
                        text: 'Already a member? ',
                        style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.white),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: '  Sign in',
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //TODO link to email password
                              Navigator.pushNamed(context, LoginPage.id);
                            }),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinkedLabelCheckbox extends StatelessWidget {
  const LinkedLabelCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    theme:
    ThemeData(unselectedWidgetColor: Colors.grey);
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            focusColor: Colors.white,
            activeColor: Colors.grey,
            checkColor: Color(0xFF220EE2),
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
          RichText(
            text: TextSpan(
              text: "I accept the ",
              style: TextStyle(
                  fontFamily: 'SöhneBreitTest',
                  fontSize: 12.0,
                  color: Colors.white),
            ),
          ),
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                fontFamily: 'SöhneBreitTest',
                fontSize: 12.0,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Label has been tapped.');
                },
            ),
          ),
        ],
      ),
    );
  }
}

class MyTermsAndConditions extends StatefulWidget {
  MyTermsAndConditions({Key key}) : super(key: key);

  @override
  _MyTermsAndConditions createState() => _MyTermsAndConditions();
}

class _MyTermsAndConditions extends State<MyTermsAndConditions> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return LinkedLabelCheckbox(
      label: 'terms and conditions',
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}
