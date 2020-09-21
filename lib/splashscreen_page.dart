import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forteapp/splashscreen1_page.dart';
//import 'package:forteapp/welcome_page.dart';

class SplashscreenPage extends StatefulWidget {
  static const String id = 'splashscreen_page';

  @override
  _SplashscreenPageState createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushNamed(context, Splashscreen1Page.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.black),
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
    );
  }
}
