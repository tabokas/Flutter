import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:forteapp/payment_location.dart';
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
  bool _sstChecked = false;
  bool _weightmanagementChecked = false;
  bool _toningshapingChecked = false;
  bool _bodybuildingChecked = false;
  bool _ppnChecked = false;
  bool _personalChecked = false;
  bool _yogaChecked = false;
  bool _wellnessCoachChecked = false;
  bool _strengthChecked = false;
  bool _boxingChecked = false;
  bool _speedagilityChecked = false;
  bool _hiitChecked = false;
  bool _pilatesChecked = false;

  bool _isEnablePersonal = false;
  bool _isEnableYoga = false;
  bool _isEnableWellness = false;
  bool _isEnabledStrength = false;



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
  final TextEditingController _YogarateFacilityController =
  new TextEditingController();
  final TextEditingController _YogarateHomeController = new TextEditingController();
  final TextEditingController _YogarateOutdoorController =
  new TextEditingController();
  final TextEditingController _YogarateOnlineCoachingController =
  new TextEditingController();
  final TextEditingController _WellnessrateFacilityController =
  new TextEditingController();
  final TextEditingController _WellnessrateHomeController = new TextEditingController();
  final TextEditingController _WellnessrateOutdoorController =
  new TextEditingController();
  final TextEditingController _WellnessrateOnlineCoachingController =
  new TextEditingController();
  final TextEditingController _SCrateFacilityController =
  new TextEditingController();
  final TextEditingController _SCrateHomeController = new TextEditingController();
  final TextEditingController _SCrateOutdoorController =
  new TextEditingController();
  final TextEditingController _SCrateOnlineCoachingController =
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
  String YogaatFacility;
  String YogaatHome;
  String Yogaoutdoors;
  String YogaonlineCoaching;
  String WellnessatFacility;
  String WellnessatHome;
  String Wellnessoutdoors;
  String WellnessonlineCoaching;
  String SCatFacility;
  String SCatHome;
  String SCoutdoors;
  String SConlineCoaching;
  String link;

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
            "s".toUpperCase(),
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

                    // Personal Trainer Check button
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

                    // Yoga Instructor checkbox
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
                              _isEnableYoga = ! _isEnableYoga;
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
                                    showYogaRates(value);
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

                    // Wellness check box
                    Expanded(
                      flex: 1,
                      child: ButtonTheme(
                        height: 100.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _wellnessCoachChecked = !_wellnessCoachChecked;
                              _isEnableWellness = !_isEnableWellness;
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
                                    showWellnessRates(value);
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

                    // Strength and conditioning  checkbox
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
                              _isEnabledStrength =!_isEnabledStrength;
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
                                    showStrenghtandConRates(value);
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
                          "Weight Management",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _weightmanagementChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _weightmanagementChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Toning and Shaping",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _toningshapingChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _toningshapingChecked = value;
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
                          "Boxing",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _boxingChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _boxingChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Body Building",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _bodybuildingChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _bodybuildingChecked = value;
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
                          "Sports Specific Training",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _sstChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _sstChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Pre and Postnatal",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _ppnChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _ppnChecked = value;
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
                          "Speed and Agility",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _speedagilityChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _speedagilityChecked = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "HIIT",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _hiitChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _hiitChecked = value;
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
                          "Yoga",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
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
                    ),
                    Expanded(
                      flex: 1,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Pilates",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Colors.black,
                        value: _pilatesChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _pilatesChecked = value;
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

            // personality Rates form

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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
                "Yoga Hourly Rates",
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
                  controller: _YogarateFacilityController,
                  onSaved: (value) {
                    YogaatFacility = value;
                  },
                  decoration: InputDecoration(
                    labelText: "AT FACILITY",
                    hintText: 'R350',
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
                  controller: _YogarateHomeController,
                  onSaved: (value) {
                    YogaatHome = value;
                  },
                  decoration: InputDecoration(
                    labelText: "AT HOME",
                    hintText: 'R350',
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
                  controller: _YogarateOutdoorController,
                  onSaved: (value) {
                    Yogaoutdoors = value;
                  },
                  decoration: InputDecoration(
                    labelText: "OUTDOORS",
                    hintText: 'R350',
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
                  controller: _YogarateOnlineCoachingController,
                  onSaved: (value) {
                    YogaonlineCoaching = value;
                  },
                  decoration: InputDecoration(
                    labelText: "ONLINE COACHING",
                    hintText: 'R350',
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
                "Wellness Hourly Rates",
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
                  controller: _WellnessrateFacilityController,
                  onSaved: (value) {
                    WellnessatFacility = value;
                  },
                  decoration: InputDecoration(
                    labelText: "AT FACILITY",
                    hintText: 'R350',
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
                  controller: _WellnessrateHomeController,
                  onSaved: (value) {
                    WellnessatHome = value;
                  },
                  decoration: InputDecoration(
                    labelText: "AT HOME",
                    hintText: 'R350',
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
                  controller: _WellnessrateOutdoorController,
                  onSaved: (value) {
                    Wellnessoutdoors = value;
                  },
                  decoration: InputDecoration(
                    labelText: "OUTDOORS",
                    hintText: 'R350',
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
                  controller: _WellnessrateOnlineCoachingController,
                  onSaved: (value) {
                    WellnessonlineCoaching = value;
                  },
                  decoration: InputDecoration(
                    labelText: "ONLINE COACHING",
                    hintText: 'R350',
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
                "Strength and Conditioning Hourly Rates",
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
                  controller: _SCrateFacilityController,
                  onSaved: (value) {
                    SCatFacility = value;
                  },
                  decoration: InputDecoration(
                    labelText: "AT FACILITY",
                    hintText: 'R350',
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
                  controller: _SCrateHomeController,
                  onSaved: (value) {
                    SCatHome = value;
                  },
                  decoration: InputDecoration(
                    labelText: "AT HOME",
                    hintText: 'R350',
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
                  controller: _SCrateOutdoorController,
                  onSaved: (value) {
                    SCoutdoors = value;
                  },
                  decoration: InputDecoration(
                    labelText: "OUTDOORS",
                    hintText: 'R350',
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
                  controller: _SCrateOnlineCoachingController,
                  onSaved: (value) {
                    SConlineCoaching = value;
                  },
                  decoration: InputDecoration(
                    labelText: "ONLINE COACHING",
                    hintText: 'R350',
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

            // Yoga Rates
            Visibility(
              visible: _isEnableYoga,
              child:YogaRates()
            ),

            // Wellness Coach Rates
           Visibility(
             visible: _isEnableWellness,
             child:WellnessRates()

           ),

            //Strength and Conditioning Rates
            Visibility(
              visible: _isEnabledStrength,
              child:StrengthandConRates()
            ),

            // Add link
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

            // Enter link text box
            Container(
              child: TextFormField(
                  controller: _onlineClassLinkController,
                  onSaved: (value) {
                    link = value;
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
                      if (_isEnablePersonal = true) {
                      setState(() {
                        _formKey.currentState.save();
                        _sstChecked;
                        _weightmanagementChecked;
                        _toningshapingChecked;
                        _bodybuildingChecked;
                        _ppnChecked;
                        _personalChecked;
                        _yogaChecked;
                        _wellnessCoachChecked;
                        _strengthChecked;
                        _boxingChecked;
                        _speedagilityChecked;
                        _hiitChecked;
                        _pilatesChecked;
                      });
                      await Firestore.instance
                          .collection('users')
                          .document(loggedinuserid)
                          .updateData({
                        'pt enabled': _isEnablePersonal,
                        'pt facility': atFacility,
                        'pt home': atHome,
                        'pt outdoors': outdoors,
                        'pt online': onlineCoaching,
                        'sst enabled': _sstChecked,
                        'weightmanagement enabled': _weightmanagementChecked,
                        'toning enabled': _toningshapingChecked,
                        'bodybuilding enabled': _bodybuildingChecked,
                        'ppn enabled': _ppnChecked,
                        'personal enabled': _personalChecked,
                        'yoga enabled': _yogaChecked,
                        'wellness enabled': _wellnessCoachChecked,
                        'strength enabled': _strengthChecked,
                        'boxing enabled': _boxingChecked,
                        'speedagility enabled': _speedagilityChecked,
                        'hiit enabled': _hiitChecked,
                        'pilates enabled': _pilatesChecked
                          });
                      Navigator.pushNamed(context, CoachProfilesPage.id);
                    }
                      if (_isEnableYoga = true) {
                        setState(() {
                          _formKey.currentState.save();
                          _sstChecked;
                          _weightmanagementChecked;
                          _toningshapingChecked;
                          _bodybuildingChecked;
                          _ppnChecked;
                          _personalChecked;
                          _yogaChecked;
                          _wellnessCoachChecked;
                          _strengthChecked;
                          _boxingChecked;
                          _speedagilityChecked;
                          _hiitChecked;
                          _pilatesChecked;
                        });
                        await Firestore.instance
                            .collection('users')
                            .document(loggedinuserid)
                            .updateData({
                          'yoga enabled': _isEnableYoga,
                          'yoga facility': YogaatFacility,
                          'yoga home': YogaatHome,
                          'yoga outdoors': Yogaoutdoors,
                          'yoga online': YogaonlineCoaching,
                          'sst enabled': _sstChecked,
                          'weightmanagement enabled': _weightmanagementChecked,
                          'toning enabled': _toningshapingChecked,
                          'bodybuilding enabled': _bodybuildingChecked,
                          'ppn enabled': _ppnChecked,
                          'personal enabled': _personalChecked,
                          'yoga enabled': _yogaChecked,
                          'wellness enabled': _wellnessCoachChecked,
                          'strength enabled': _strengthChecked,
                          'boxing enabled': _boxingChecked,
                          'speedagility enabled': _speedagilityChecked,
                          'hiit enabled': _hiitChecked,
                          'pilates enabled': _pilatesChecked
                        });
                        Navigator.pushNamed(context, CoachProfilesPage.id);
                      }
                      if (_isEnableWellness = true) {
                        setState(() {
                          _formKey.currentState.save();
                          _sstChecked;
                          _weightmanagementChecked;
                          _toningshapingChecked;
                          _bodybuildingChecked;
                          _ppnChecked;
                          _personalChecked;
                          _yogaChecked;
                          _wellnessCoachChecked;
                          _strengthChecked;
                          _boxingChecked;
                          _speedagilityChecked;
                          _hiitChecked;
                          _pilatesChecked;
                        });
                        await Firestore.instance
                            .collection('users')
                            .document(loggedinuserid)
                            .updateData({
                          'welness enabled': _isEnableWellness,
                          'wellness facility': WellnessatFacility,
                          'wellness home': WellnessatHome,
                          'wellness outdoors': Wellnessoutdoors,
                          'wellness online': WellnessonlineCoaching,
                          'sst enabled': _sstChecked,
                          'weightmanagement enabled': _weightmanagementChecked,
                          'toning enabled': _toningshapingChecked,
                          'bodybuilding enabled': _bodybuildingChecked,
                          'ppn enabled': _ppnChecked,
                          'personal enabled': _personalChecked,
                          'yoga enabled': _yogaChecked,
                          'wellness enabled': _wellnessCoachChecked,
                          'strength enabled': _strengthChecked,
                          'boxing enabled': _boxingChecked,
                          'speedagility enabled': _speedagilityChecked,
                          'hiit enabled': _hiitChecked,
                          'pilates enabled': _pilatesChecked
                        });
                        Navigator.pushNamed(context, CoachProfilesPage.id);
                      }
                      if (_isEnabledStrength = true) {
                        setState(() {
                          _formKey.currentState.save();
                          _sstChecked;
                          _weightmanagementChecked;
                          _toningshapingChecked;
                          _bodybuildingChecked;
                          _ppnChecked;
                          _personalChecked;
                          _yogaChecked;
                          _wellnessCoachChecked;
                          _strengthChecked;
                          _boxingChecked;
                          _speedagilityChecked;
                          _hiitChecked;
                          _pilatesChecked;
                        });
                        await Firestore.instance
                            .collection('users')
                            .document(loggedinuserid)
                            .updateData({
                          'sc enabled': _isEnabledStrength,
                          'sc facility': SCatFacility,
                          'sc home': SCatHome,
                          'sc outdoors': SCoutdoors,
                          'sc online': SConlineCoaching,
                          'sst enabled': _sstChecked,
                          'weightmanagement enabled': _weightmanagementChecked,
                          'toning enabled': _toningshapingChecked,
                          'bodybuilding enabled': _bodybuildingChecked,
                          'ppn enabled': _ppnChecked,
                          'personal enabled': _personalChecked,
                          'yoga enabled': _yogaChecked,
                          'wellness enabled': _wellnessCoachChecked,
                          'strength enabled': _strengthChecked,
                          'boxing enabled': _boxingChecked,
                          'speedagility enabled': _speedagilityChecked,
                          'hiit enabled': _hiitChecked,
                          'pilates enabled': _pilatesChecked
                        });
                        Navigator.pushNamed(context, CoachProfilesPage.id);
                      }
                      if (link != null) {
                        setState(() {
                          _formKey.currentState.save();
                        });
                        await Firestore.instance
                            .collection('users')
                            .document(loggedinuserid)
                            .updateData({
                          'link': link
                        });
                        Navigator.pushNamed(context, CoachProfilesPage.id);
                      }
                      if (atFacility == null &&
                      atHome == null &&
                      outdoors == null &&
                      onlineCoaching == null &&
                      YogaatFacility == null &&
                      YogaatHome == null &&
                      Yogaoutdoors == null &&
                      YogaonlineCoaching == null &&
                      WellnessatFacility == null &&
                      WellnessatHome == null &&
                      Wellnessoutdoors == null &&
                      WellnessonlineCoaching == null &&
                      SCatFacility == null &&
                      SCatHome == null &&
                      SCoutdoors == null &&
                      SConlineCoaching == null) {
                        {_displayDialog(context);};
                      }}),
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
  void showYogaRates(bool value) {
    if(_yogaChecked == false) {
      setState(() {
        _isEnableYoga = !_isEnableYoga;
      });
    }

  }

  void showWellnessRates(bool value) {
    if(_wellnessCoachChecked == false) {
      setState(() {
        _isEnableWellness = !_isEnableWellness;
      });
    }

  }

  void showStrenghtandConRates(bool value) {
    if(_strengthChecked == false) {
      setState(() {
        _isEnabledStrength = !_isEnabledStrength;
      });
    }

  }

  TextEditingController _textFieldController = TextEditingController();
  void _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please enter at least one rate'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Please enter at least one rate"),
            ),
          );
        });
  }


  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
}


class YogaRates extends StatelessWidget {

  final TextEditingController _onlineClassLinkController =
  new TextEditingController();
  final TextEditingController _rateFacilityController =
  new TextEditingController();
  final TextEditingController _rateHomeController = new TextEditingController();
  final TextEditingController _rateOutdoorController =
  new TextEditingController();
  final TextEditingController _rateOnlineCoachingController =
  new TextEditingController();

  String YogaatFacility;
  String YogaatHome;
  String Yogaoutdoors;
  String YogaonlineCoaching;

  @override
  Widget build(BuildContext context) {

    return
        Column(
     children: <Widget>[
       Container(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Yoga Hourly Rates",
          style: TextStyle(
            fontFamily: 'SöhneBreitest',
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
    YogaatFacility = value;
    },
    decoration: InputDecoration(
    labelText: "AT FACILITY",
    hintText: 'R350',
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
    YogaatHome = value;
    },
    decoration: InputDecoration(
    labelText: "AT HOME",
    hintText: 'R350',
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
    Yogaoutdoors = value;
    },
    decoration: InputDecoration(
    labelText: "OUTDOORS",
    hintText: 'R350',
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
    YogaonlineCoaching = value;
    },
    decoration: InputDecoration(
    labelText: "ONLINE COACHING",
    hintText: 'R350',
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
    ]
        );
  }

}
// ignore: must_be_immutable
class WellnessRates extends StatelessWidget {


  final TextEditingController _onlineClassLinkController =
  new TextEditingController();
  final TextEditingController _rateFacilityController =
  new TextEditingController();
  final TextEditingController _rateHomeController = new TextEditingController();
  final TextEditingController _rateOutdoorController =
  new TextEditingController();
  final TextEditingController _rateOnlineCoachingController =
  new TextEditingController();

  String atFacility;
  String atHome;
  String outdoors;
  String onlineCoaching;

  @override
  Widget build(BuildContext context) {

    return
      Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Wellness Hourly Rates",
                style: TextStyle(
                  fontFamily: 'SöhneBreitest',
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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
          ]
      );
  }

}
class StrengthandConRates extends StatelessWidget {

  final TextEditingController _onlineClassLinkController =
  new TextEditingController();
  final TextEditingController _rateFacilityController =
  new TextEditingController();
  final TextEditingController _rateHomeController = new TextEditingController();
  final TextEditingController _rateOutdoorController =
  new TextEditingController();
  final TextEditingController _rateOnlineCoachingController =
  new TextEditingController();

  String atFacility;
  String atHome;
  String outdoors;
  String onlineCoaching;

  @override
  Widget build(BuildContext context) {

    return
      Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Strength and Conditioning Hourly Rates",
                style: TextStyle(
                  fontFamily: 'SöhneBreitest',
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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
                    hintText: 'R350',
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
          ]
      );
  }

}
