import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forteapp/login_page.dart';
import 'package:forteapp/registration_page.dart';
import 'package:forteapp/user_profile_init.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:forteapp/services/cloud_storage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class CoachProfilesPage extends StatefulWidget {
  static const String id = 'coach_profiles_page';

  @override
  _CoachProfilesPageState createState() => _CoachProfilesPageState();
}

class _CoachProfilesPageState extends State<CoachProfilesPage> {
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Forte Coaches"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}


