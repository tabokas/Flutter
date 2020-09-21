import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forteapp/onboarding_page.dart';
//import 'package:forteapp/welcome_page.dart';

class Splashscreen1Page extends StatefulWidget {
  static const String id = 'splashscreen1_page';

  @override
  _Splashscreen1PageState createState() => _Splashscreen1PageState();
}

class _Splashscreen1PageState extends State<Splashscreen1Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),
        () => Navigator.pushNamed(context, OnboardingPage.id));
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage('images/hipcravo-5-ub-iq-v-58-cw-8-unsplash.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.transparent),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Image(
                                image: AssetImage(
                                  //'images/welcome_leaveapp_00.jpg',
                                  'images/Forte-logo-appstyle-W.png',
                                ),
                                height: 200.0,
                                width: 300.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.pinkAccent,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
