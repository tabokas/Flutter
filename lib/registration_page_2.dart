import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up Page"),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              //added alignments
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Column(children: [
                  Text(
                    'Sign Up Information',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: "Email Address")),
                  TextFormField(
                      // keyboardType: TextInputType.fullName,
                      decoration: InputDecoration(labelText: "Full Name")),
                  TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: "Password")),
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
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, CoachProfilesPage.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      }),
                ])),
              ],
            ),
          ),
        ));
  }
}
