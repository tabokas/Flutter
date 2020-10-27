import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:forteapp/registration_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:forteapp/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forteapp/services/cloud_storage_service.dart';
import 'package:auro_avatar/auro_avatar.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class SkillsRatesPage extends StatefulWidget {
  static const String id = 'skills_rates_page';
  String usertypevalue;
  SkillsRatesPage({Key key, @required this.usertypevalue}) : super(key: key);

  @override
  _SkillsRatesPageState createState() =>
      _SkillsRatesPageState(usertypevalue: usertypevalue);
}

class _SkillsRatesPageState extends State<SkillsRatesPage> {
  String usertypevalue;

  _SkillsRatesPageState({this.usertypevalue});

  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;
  bool _wellnessChecked = false;
  bool _weightLossChecked = false;
  bool _bodyBuildingChecked = false;
  bool _enduranceChecked = false;
  bool _toningChecked = false;
  bool _personalChecked = false;
  bool _yogaChecked = false;
  bool _wellnessCoachChecked = false;
  bool _strengthChecked = false;

  //_UserProfileInitPageState(this.userType);

  // TextControllers: All this will be in nice neat classes
  final TextEditingController _onlineClassLinkController =
      new TextEditingController();
  final TextEditingController _rateFacilityController =
      new TextEditingController();
  final TextEditingController _rateHomeController = new TextEditingController();
  final TextEditingController _rateOutdoorController =
      new TextEditingController();
  final TextEditingController _rateOnlineCoachingController =
      new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState additional code
    super.initState();
    getCurrentUser();
  }

  bool showSpinner = false;
  String atFacility;
  String atHome;
  String outdoors;
  String onlineCoaching;

  String loggedinuseremail;
  String loggedinuserid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        loggedinuseremail = loggedInUser.email;
        loggedinuserid = loggedInUser.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.maybePop(context);
              },
            );
          },
        ),
        elevation: 0,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Skills & Rates',
            style: TextStyle(
              fontFamily: 'SöhneBreitTest',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
        ),
        actions: <Widget>[
          // Displaying the user name Intials
          InitialNameAvatar(
            "${user?.displayName}".toUpperCase(),
            circleAvatar: true,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            borderSize: 8.0,
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        //Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child: Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: <Widget>[
            Container(
              child: SizedBox(
                height: 20.0,
              ),
            ),
            Container(
              child: Text(
                "What service(s) do you offer?",
                style: TextStyle(
                  fontFamily: 'SöhneBreitTest',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
            ),
            Column(
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonTheme(
                        height: 100.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _personalChecked = !_personalChecked;
                            });
                          },
                          color: _personalChecked
                              ? Colors.black
                              : Color(0xFFEEEEEE),
                          child: Column(
                            children: <Widget>[
                              CheckboxListTile(
                                contentPadding: EdgeInsets.all(0),
                                activeColor: Color(0xFFDDDDDD),
                                checkColor: Colors.black,
                                value: _personalChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    _personalChecked = value;
                                  });
                                },
                              ),
                              Text(
                                "PERSONAL TRAINER",
                                style: TextStyle(
                                  fontFamily: 'SöhneBreitTest',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          textColor:
                              _personalChecked ? Colors.white : Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonTheme(
                        height: 100.0,
                        child: RaisedButton(
                          color:
                              _yogaChecked ? Colors.black : Color(0xFFEEEEEE),
                          onPressed: () {
                            setState(() {
                              _yogaChecked = !_yogaChecked;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              CheckboxListTile(
                                contentPadding: EdgeInsets.all(0),
                                activeColor: Color(0xFFDDDDDD),
                                checkColor: Colors.black,
                                value: _yogaChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    _yogaChecked = value;
                                  });
                                },
                              ),
                              Text(
                                "YOGA INSTRUCTOR",
                                style: TextStyle(
                                  fontFamily: 'SöhneBreitTest',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          textColor: _yogaChecked ? Colors.white : Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 120.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonTheme(
                        height: 100.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _wellnessCoachChecked = !_wellnessCoachChecked;
                            });
                          },
                          color: _wellnessCoachChecked
                              ? Colors.black
                              : Color(0xFFEEEEEE),
                          child: Column(
                            children: <Widget>[
                              CheckboxListTile(
                                contentPadding: EdgeInsets.all(0),
                                activeColor: Color(0xFFDDDDDD),
                                checkColor: Colors.black,
                                value: _wellnessCoachChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    _wellnessCoachChecked = value;
                                  });
                                },
                              ),
                              Text(
                                "WELLNESS COACH",
                                style: TextStyle(
                                  fontFamily: 'SöhneBreitTest',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          textColor: _wellnessCoachChecked
                              ? Colors.white
                              : Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonTheme(
                        height: 100.0,
                        child: RaisedButton(
                          color: _strengthChecked
                              ? Colors.black
                              : Color(0xFFEEEEEE),
                          onPressed: () {
                            setState(() {
                              _strengthChecked = !_strengthChecked;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              CheckboxListTile(
                                contentPadding: EdgeInsets.all(0),
                                activeColor: Color(0xFFDDDDDD),
                                checkColor: Colors.black,
                                value: _strengthChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    _strengthChecked = value;
                                  });
                                },
                              ),
                              Text(
                                "STRENGTH & CONDITIONING",
                                style: TextStyle(
                                  fontFamily: 'SöhneBreitTest',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          textColor:
                              _strengthChecked ? Colors.white : Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Add your specialities",
                    style: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "weight loss",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _weightLossChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _weightLossChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "body building",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _bodyBuildingChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _bodyBuildingChecked = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "body building",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _bodyBuildingChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _bodyBuildingChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "endurance",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _enduranceChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _enduranceChecked = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "wellness",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _wellnessChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _wellnessChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "toning",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _toningChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _toningChecked = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "toning",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _toningChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _toningChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "weight loss",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _weightLossChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _weightLossChecked = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "endurance",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _enduranceChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _enduranceChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "wellness",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _wellnessChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _wellnessChecked = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20.0),
            ),
            Container(
              child: SizedBox(
                width: 50.0,
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Personal Training Hourly Rates",
                style: TextStyle(
                  fontFamily: 'SöhneBreitTest',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              child: TextFormField(
                  controller: _rateFacilityController,
                  onSaved: (value) {
                    atFacility = value;
                  },
                  decoration: InputDecoration(
                    labelText: "AT FACILITY",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      fontSize: 12.0,
                      color: Color(0xFFA6A6A6),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFDDDDDD),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              child: TextFormField(
                  controller: _rateHomeController,
                  onSaved: (value) {
                    atHome = value;
                  },
                  decoration: InputDecoration(
                    labelText: "AT HOME",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      fontSize: 12.0,
                      color: Color(0xFFA6A6A6),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFDDDDDD),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              child: TextFormField(
                  controller: _rateOutdoorController,
                  onSaved: (value) {
                    outdoors = value;
                  },
                  decoration: InputDecoration(
                    labelText: "OUTDOORS",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      fontSize: 12.0,
                      color: Color(0xFFA6A6A6),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFDDDDDD),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              child: TextFormField(
                  controller: _rateOnlineCoachingController,
                  onSaved: (value) {
                    onlineCoaching = value;
                  },
                  decoration: InputDecoration(
                    labelText: "ONLINE COACHING",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      fontSize: 12.0,
                      color: Color(0xFFA6A6A6),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFDDDDDD),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Add link for online classes",
                style: TextStyle(
                  fontFamily: 'SöhneBreitTest',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              child: TextFormField(
                  controller: _onlineClassLinkController,
                  onSaved: (value) {
                    atFacility = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Paste link here",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      fontSize: 12.0,
                      color: Color(0xFFA6A6A6),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFDDDDDD),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                  )),
            ),
            Container(
              child: SizedBox(
                height: 70.0,
              ),
            ),
            Container(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: RaisedButton(
                    child: Text(
                      "SAVE & COMPLETE",
                      style: TextStyle(
                        fontFamily: 'SöhneBreitTest',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        letterSpacing: 0.5,
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xFF220EE2),
                    textColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () async {
                      //Missing validation and posting to Firebase
                      Navigator.pushNamed(context, CoachProfilesPage.id);
                    }),
              ),
            ),
            Container(
              child: SizedBox(
                height: 40.0,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
}
