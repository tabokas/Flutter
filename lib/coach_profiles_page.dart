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



class CoachProfilesPage extends StatefulWidget {
  static const String id = 'coach_profiles_page';

  @override
  _CoachProfilesPageState createState() => _CoachProfilesPageState();
}

class _CoachProfilesPageState extends State<CoachProfilesPage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String _retrievedImageUrl;
  Firestore _firestore = Firestore.instance;



  Future retrieveImage() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await _firestore.collection("users").document("loggedinuserid").get();
      setState(() {
        _retrievedImageUrl = documentSnapshot.data["profilePicture"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

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
