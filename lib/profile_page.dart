import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
//import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:forteapp/login_page.dart';

class UserProfileInitPage extends StatefulWidget {
  static const String id = 'userprofileinit_page';

  @override
  _UserProfileInitPageState createState() => _UserProfileInitPageState();
}

class _UserProfileInitPageState extends State<UserProfileInitPage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    // TODO: implement initState additional code
    super.initState();
    getCurrentUser();
  }

  bool showSpinner = false;
  //String email;
  //String password;
  String fullname;

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'ZA';
  PhoneNumber number = PhoneNumber(isoCode: 'ZA');

  DateTime _dateTime;
  DateTime _date = DateTime.now();

  File imageFile;
  //final picker = ImagePicker();

  String loggedinuseremail;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        loggedinuseremail = loggedInUser.email;
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

  _openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
  }

  _openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Load ID/Passport"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile"),
      ),
      resizeToAvoidBottomInset: true,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
              //added alignments
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.filter,
                          color: Colors.black,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                      Text(
                        "$loggedinuseremail",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                    // keyboardType: TextInputType.fullName,
                    decoration: InputDecoration(labelText: "Full Name")),
                Container(
                  padding: EdgeInsets.all(20.0),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Text(
                        _date == null
                            ? " Pick DOB "
                            : "DoB: ${_date.toString().substring(0, 10)}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          selectedDate(context);
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                    // keyboardType: TextInputType.fullName,
                    decoration:
                        InputDecoration(labelText: "ID / Passport Number")),
                Container(
                  padding: EdgeInsets.all(20.0),
                ),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  ignoreBlank: false,
                  autoValidate: false,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: controller,
                  inputBorder: OutlineInputBorder(),
                ),
                TextFormField(
                    onChanged: (value) {
                      //  password = value;
                    },
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        labelText: "Capture ID/Passport or Load PDF")),
                RaisedButton(onPressed: () {
                  _showChoiceDialog(context);
                }),
                RaisedButton(
                    child: Text("SIGN UP"),
                    color: Colors.pink,
                    textColor: Colors.white,
                    elevation: 5,
                    shape: StadiumBorder(),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        //print(email);
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
