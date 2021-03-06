import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:forteapp/registration_page.dart';
import 'coach_profiles_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:forteapp/user_profile_init.dart';

class TCPage extends StatefulWidget {
  static const String id = 't_c_page';

  @override
  _TCPageState createState() => _TCPageState();
}

class _TCPageState extends State<TCPage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black87,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
            // do something
          },
          color: Colors.black,
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: TextStyle(color: Colors.black),
            )
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
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: ListView(
          children: <Widget>[
            Container(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(30.0),
              child: Column(
                //added alignments
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    '', //remove 'Login Information'
                    style: TextStyle(fontSize: 20),
                  ),
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
                            text: 'Sign in to your \naccount ',

                            style: TextStyle(
                              fontFamily: 'SöhneBreitTest',
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                            // textAlign: TextAlign.center,
                            children: <TextSpan>[
                              TextSpan(
                                text: '\n',
                                style: TextStyle(
                                  fontFamily: 'SöhneBreitTest',
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      style: TextStyle(
                        fontFamily: 'SöhneBreitTest',
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          // fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          color: Colors.black,
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
                        color: Colors.black,
                      ),
                      obscureText: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          // fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          color: Colors.black,
                        ),
                      )),
                  SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Forgot Password?',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //TODO link to email password
                            print('Testing Link');
                          }),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: RaisedButton(
                        //color: Colors.lightBlueAccent,
                        //shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(18.0)),
                        //: BorderRadius.circular(30.0),

                        child: Text(
                          "SIGN IN",
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
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Color(0xFF220EE2))),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
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
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?  ',
                            style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontSize: 12.0,
                                color: Colors.black),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: '  Get Started',
                              style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //TODO link to email password
                                  Navigator.pushNamed(
                                      context, RegistrationPage.id);
                                }),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
