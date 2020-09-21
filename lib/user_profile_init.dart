import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:forteapp/profile_page.dart';
import 'package:forteapp/registration_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
//import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:forteapp/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:forteapp/registration_page.dart';
import 'package:auro_avatar/auro_avatar.dart';

enum TypeOfID { idNumber, Passport }
TypeOfID selectedType;

class UserProfileInitPage extends StatefulWidget {
  static const String id = 'userprofileinit_page';
  String usertypevalue;
  UserProfileInitPage({Key key, @required this.usertypevalue})
      : super(key: key);

  @override
  _UserProfileInitPageState createState() =>
      _UserProfileInitPageState(usertypevalue: usertypevalue);
}

class _UserProfileInitPageState extends State<UserProfileInitPage> {
  String usertypevalue;
  _UserProfileInitPageState({this.usertypevalue});

  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;
  bool pressAttention = true;
  bool pressText = true;

  //_UserProfileInitPageState(this.userType);

  // TextControllers: All this will be in nice neat classes
  final TextEditingController _fullNameController = new TextEditingController();
  final TextEditingController _phoneNumberController =
      new TextEditingController();
  final TextEditingController _dateOfBirthController =
      new TextEditingController();
  final TextEditingController _typeOfIDController = new TextEditingController();
  final TextEditingController _idNumberController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState additional code
    super.initState();
    getCurrentUser();
  }

  bool showSpinner = false;
  //String email;
  //String password;
  String fullName;
  String phoneNumber;
  String dateOfBirth;
  String typeOfIDString;
  String idNumber;

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'ZA';
  PhoneNumber number = PhoneNumber(isoCode: 'ZA');

  DateTime _dateTime;
  DateTime _date = DateTime.now();

  // File imageFile;
  final _picker = ImagePicker();
  //final picker = ImagePicker();

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

  Future<Null> selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1940),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != _date) {
      print(_date.toString());
      setState(() {
        _date = picked;
      });
    }
  }

  File _pickedImage;

  _openGallery() async {
    final picture =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    final File pictureImage = File(picture.path);
    // var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      // _picker = pictureImage;
      _pickedImage = pictureImage;
    });
  }

  _openCamera() async {
    final picture =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    final File pictureImage = File(picture.path);
    // var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      // imageFile = picture;
      _pickedImage = pictureImage;
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Load from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery();
                    },
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(8.0,0.0,8.0,0.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final PassUserType args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // automaticallyImplyLeading: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.maybePop(context);
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        elevation: 0,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Your Profile',
            style: TextStyle(
              fontFamily: 'SöhneBreitTest',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.black,
            ),
            // textAlign: TextAlign.center,
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
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Form(
          //inAsyncCall: showSpinner,
          key: _formKey,
          child: ListView(
              //added alignments
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFEEEEEE),
                          radius: 25.0,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage)
                              : null,
                          child: _pickedImage != null
                              ? null
                              : Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 15.0,
                                ),
                        ),
                      ),
                      //SizedBox(
                      //  height: 10.0,
                     // ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 5.0),
                      // ),
                      Center(
                        child: Text(
                          "Upload Profile Photo",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.usertypevalue}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                //SizedBox(
                //  height: 20.0,
              //  ),
                TextFormField(
                    controller: _fullNameController,
                    //validator: validateEmail,
                    onSaved: (value) {
                      fullName = value;
                    },
                    //  keyboardType: TextInputType.fullName,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                        fontFamily: 'SöhneBreitTest',
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.grey,
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
                Container(
                  padding: EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
                ),
                TextFormField(
                    controller: _phoneNumberController,
                    //validator: validateEmail,
                    onSaved: (value) {
                      phoneNumber = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(
                        fontFamily: 'SöhneBreitTest',
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Color(0xffA6A6A6),
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
                Container(
                  padding: EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
                ),
                TextFormField(
                    controller: _dateOfBirthController,
                    //validator: validateEmail,
                    onSaved: (value) {
                      dateOfBirth = value;
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: "Date of Birth (yyyy-mm-dd)",
                      labelStyle: TextStyle(
                        fontFamily: 'SöhneBreitTest',
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Color(0xffA6A6A6),
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
                Container(
                  padding: EdgeInsets.fromLTRB(20.0,5.0,20.0,5.0),
                ),

                Text(
                  "Type of identification",
                  style: TextStyle(
                    fontFamily: 'SöhneBreitTest',
                    //fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                ),
                Row(
                  //mainAxisSize: MediaQuery.of(context).size.width * 0.8,
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonTheme(
                        height: 40.0,
                        child: RaisedButton(
                          //shape: RoundedRectangleBorder(
                          //borderRadius: BorderRadius.circular(18.0)),
                          //: BorderRadius.circular(30.0),
                          onPressed: () {
                            setState(() {
                              typeOfIDString = "ID Number";
                              selectedType = TypeOfID.idNumber;
                              //   athleteColor = 0xFFFFFFFF;
                              //   coachColor = 0xFF9E9E9E;

                              //  print("athlete clicked");
                              //  pressAttention = true;
                              pressText = true;

                              highlightColor:
                              //Color(athleteColor)
                              ;
                            });
                          },
                          // highlightColor: Color(athleteColor),
                          color: selectedType == TypeOfID.idNumber
                              ? Colors.black
                              : Color(0xFFEEEEEE),

                          // color:
                          // pressAttention ? Colors.black : Color(0xffEEEEEE),
                          child: Text(
                            "ID NUMBER",
                            style: TextStyle(
                              fontFamily: 'SöhneBreitTest',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              //color: Color(0xFF220EE2),
                            ),
                          ),
                          //color: Color(athleteColor),
                          textColor: selectedType == TypeOfID.idNumber
                              ? Colors.white
                              : Colors.black,

                          //  textColor: pressText ? Color(0xffEEEEEE) : Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Color(0xFFEEEEEE))
                          ),
                        ),
                      ),
                    ),
                    //SizedBox(
                     // width: 10.0,
                   // ),
                    Expanded(
                      flex: 1,
                      child: ButtonTheme(
                        height: 40.0,
                        child: RaisedButton(
                          //color: Color(coachColor),
                          //shape: RoundedRectangleBorder(
                          //borderRadius: BorderRadius.circular(18.0)),
                          //: BorderRadius.circular(30.0),

                          // color:
                          //     pressAttention ? Color(0xffEEEEEE) : Colors.black,

                          color: selectedType == TypeOfID.Passport
                              ? Colors.black
                              : Color(0xFFEEEEEE),

                          onPressed: () {
                            setState(() {
                              typeOfIDString = "Passport";
                              selectedType = TypeOfID.Passport;

                              // pressAttention = false;
                              pressText = false;
                            });
                          },
                          child: Text(
                            "PASSPORT",
                            style: TextStyle(
                              fontFamily: 'SöhneBreitTest',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              // color: Color(0xFF220EE2),
                            ),
                          ),
                          // color: Color(coachColor),

                          textColor: selectedType == TypeOfID.Passport
                              ? Colors.white
                              : Colors.black,

                          // textColor: pressText ? Colors.black : Color(0xffEEEEEE),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Color(0xFFEEEEEE))
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 5.0,
                    // ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
                ),
               // SizedBox(
               //   width: 5.0,
              //  ),
                TextFormField(
                    controller: _idNumberController,
                    //validator: validateEmail,
                    onSaved: (value) {
                      idNumber = value;
                    },
                    //  keyboardType: TextInputType.fullName,
                    decoration: InputDecoration(
                      labelText: pressText
                          ? "Enter ID Number"
                          : "Enter Passport Number",
                      labelStyle: TextStyle(
                        fontFamily: 'SöhneBreitTest',
                        //fontWeight: FontWeight.bold,
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
                //SizedBox(
               //   width: 5.0,
              //  ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
                ),
                ButtonTheme(
                  height: 100.0,
                  child: RaisedButton(
                      color: Color(0xFFEEEEEE),
                      elevation: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              " ",
                              style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xFFEEEEEE),
                            radius: 20.0,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                          Center(
                            child: Text(
                              pressText ? "Upload Passport Photo" : "Upload Passport Photo",
                              style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              " ",
                              style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              " ",
                              style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 50.0,
                          // ),
                        ],
                      ),
                      onPressed: () {
                        _showChoiceDialog(context);
                      }),
                ),
                // Container(
                //   padding: EdgeInsets.all(10.0),
                // ),
                SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: RaisedButton(
                      child: Text(
                        "SAVE CHANGES",
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
                        // side: BorderSide(color: Color(0xFF220EE2))
                      ),
                      onPressed: () async {
                        setState(() {
                          _formKey.currentState.save();
                          //   showSpinner = true;
                        });
                        try {
                          print(loggedinuserid);
                          print(loggedinuseremail);
                          await Firestore.instance
                              .collection('users')
                              .document(loggedinuserid)
                              .setData({
                            'fullname': fullName,
                            'phonenumber': phoneNumber,
                            'dateofbirth': dateOfBirth,
                            'typeofid': typeOfIDString,
                            'idnumber': idNumber,
                            'usertype': "$usertypevalue",
                          });
                          //print(password);
                          //  final newUser =
                          //     await _auth.createUserWithEmailAndPassword(
                          //        email: email, password: password);
                          //if (newUser != null) {
                          Navigator.pushNamed(context, CoachProfilesPage.id);
                          //}
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      }),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ]),
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'ZA');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
