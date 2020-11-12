import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:forteapp/user_profile_init.dart';
import 'package:flutter/gestures.dart';
import 'package:forteapp/login_page.dart';
import 'package:path/path.dart';
import 't_c_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forteapp/user_profile_init.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forteapp/styles/my_flutter_app_icons.dart';

enum TypeOfUser { athlete, instructor }
TypeOfUser selectedUser;

class AthleteProfilePage extends StatefulWidget {
  static const String id = 'athleteprofile_page';

  @override
  _AthleteProfilePageState createState() => _AthleteProfilePageState();
}

class _AthleteProfilePageState extends State<AthleteProfilePage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String confirmpassword;
  //bool _isSelected = false;

  String TypeOfUserString = "athlete";

  String _error;
  //validators
  final GlobalKey<FormState> _key = new GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();
  final TextEditingController _mobileController = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool visible = true;
  // bool pressAttention = false;
  // bool pressText = false;
  bool _termsChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int athleteColor = 0xFF9E9E9E;
    int coachColor = 0xFF9E9E9E;
//0xFF000000 black  0xFFFFFFFF  white      0x3DFFFFFF white 12/   0xFF424242    grey 0xFF9E9E9E
    //theme:
    //ThemeData(unselectedWidgetColor: Colors.grey);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/group-5@2x.png',
              fit: BoxFit.contain,
              height: 20,
            ),
            // Container(padding: const EdgeInsets.all(1.0),
            //    child: Text(''))
          ],
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        //title: Text("Login Page"),
        backgroundColor: Colors.white,
        elevation: 0.0,
        //backgroundColor: Colors.black87, //removed Login Page
      ),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child: Form(
          key: _formKey,
          // was key: _key
          autovalidate: _validate,
          child: ListView(
            //added alignments
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisSize: MediaQuery.of(context).size.width * 0.8,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color(0xFFEEEEEE),
                        radius: 30.0,
                        backgroundImage: null,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Mike Mann",
                        style: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          //color: Color(0xFF220EE2),
                        ),
                      ),
                      // SizedBox(
                      //   width: 5.0,
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 60.0,
                child: Card(
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      print("tapped the Edit card");
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(MyFlutterApp.menu1),
                        SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            // fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              Container(
                height: 60.0,
                child: Card(
                  elevation: 0,
                  child: Row(
                    children: <Widget>[
                      Icon(MyFlutterApp.menu1),
                      SizedBox(
                        width: 20.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Help",
                        style: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          // fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              Container(
                height: 60.0,
                child: Card(
                  elevation: 0,
                  child: Row(
                    children: <Widget>[
                      Icon(MyFlutterApp.menu1),
                      SizedBox(
                        width: 20.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          // fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              SizedBox(
                height: 100.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: 'Terms and conditions',
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.black,
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

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Confirm password is required';
    } else if (value.length < 6) {
      return 'Confirm password must be at least 4 characters';
    }
    return null;
  }

  bool validationEqual(String currentValue, String checkValue) {
    if (currentValue == checkValue) {
      return true;
    } else {
      return false;
    }
  }
}

class PassUserType {
  final String userType;

  PassUserType(this.userType);
}
