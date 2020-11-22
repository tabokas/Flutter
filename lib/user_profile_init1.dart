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
//import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:forteapp/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forteapp/services/cloud_storage_service.dart';
import 'package:auro_avatar/auro_avatar.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

enum TypeOfID { idNumber, Passport }
TypeOfID selectedType;



class UserProfileInit1Page extends StatefulWidget {
  static const String id = 'userprofileinit1_page';
  String usertypevalue;
  UserProfileInit1Page({Key key, @required this.usertypevalue})
      : super(key: key);

  @override
  _UserProfileInit1PageState createState() =>
      _UserProfileInit1PageState(usertypevalue: usertypevalue);
}

class _UserProfileInit1PageState extends State<UserProfileInit1Page> {
  String usertypevalue;

  _UserProfileInit1PageState({this.usertypevalue});

  final _auth = FirebaseAuth.instance;


  FirebaseUser loggedInUser;
  bool pressAttention = true;
  bool pressText = true;

  //_UserProfileInitPageState(this.userType);


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState additional code
    super.initState();
    getCurrentUser();
  }

  bool showSpinner = false;



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

  File _pickedImage;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _pickedImage = selected;
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
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () => _pickImage(ImageSource.camera),
                  ),

                ],
              ),
            ),
          );
        });
  }

  String imageUrl;
  PickedFile image;



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
        //Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child: Form(
          //inAsyncCall: showSpinner,
          key: _formKey,
          //physics: AlwaysScrollableScrollPhysics(),
          child: ListView(
              shrinkWrap: true,
              //physics: AlwaysScrollableScrollPhysics(),
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
                          radius: 45.0,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage)
                              : null,
                          child: _pickedImage != null
                              ? null
                              : Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
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
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Container(
                  child: SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.08,
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
                        onPressed: ()async {
                          if (_pickedImage != null) {var file = File(image.path);
                          var filePath = 'images/${DateTime.now()}.png';
                          StorageReference ref = FirebaseStorage.instance.ref();
                          StorageTaskSnapshot addImg = await ref.child(filePath).putFile(file).onComplete;
                          if (addImg.error == null) {
                          print("added profile photo to Firebase Storage");

                          setState(() {
                            _formKey.currentState.save();
                            Navigator.pushNamed(context, CoachProfilesPage.id);
                          }  //   showSpinner = true;
                          );
                        }}}),
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 40.0,
                  ),
                ),
              ]
          ),
        ), //)
      ),
    );
  }

  }
