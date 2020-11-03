import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forteapp/services/cloud_storage_service.dart';
import 'package:forteapp/styles/styles.dart';
import 'package:forteapp/login_page.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:forteapp/registration_page.dart';

class OnboardingPage extends StatefulWidget {
  static const String id = 'onboarding_page';

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        //Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 200.0,
        right: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
      ),
    );

    overlayState.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                      //   showOverlay(context);
                    });
                  },
                  children: <Widget>[
                    DecoratedBox(
                      position: DecorationPosition.background,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage(
                                'images/hipcravo-5-ub-iq-v-58-cw-8-unsplash.png'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          Expanded(
                            flex: 1,
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
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'FIND A \nCOACH',
                                  style: TextStyle(
                                    fontFamily: 'SöhneBreitTest',
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 50.0,
                                    color: Colors.white,
                                  ),
                                  // textAlign: TextAlign.right,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '\nOur hand picked trainers can \ntake you from novice to pro.',
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
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildPageIndicator(),
                          ),
                          SizedBox(height: 20.0),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(30.0),
                              child: RaisedButton(

                                  //color: Colors.lightBlueAccent,
                                  //shape: RoundedRectangleBorder(
                                  //borderRadius: BorderRadius.circular(18.0)),
                                  //: BorderRadius.circular(30.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'GET STARTED',
                                      style: TextStyle(
                                        fontFamily: 'SöhneBreitTest',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  color: Color(0xFF220EE2),
                                  textColor: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side:
                                          BorderSide(color: Color(0xFF220EE2))),
                                  onPressed: () async {
                                    setState(() {
                                      Navigator.pushNamed(
                                          context, RegistrationPage.id);
                                    });
                                  }),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                    DecoratedBox(
                      position: DecorationPosition.background,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage(
                                'images/shutterstock-1344377009.png'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          Expanded(
                            flex: 1,
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
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: '  FIND \nA SPOT',
                                  style: TextStyle(
                                    fontFamily: 'SöhneBreitTest',
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 40.0,
                                    color: Colors.white,
                                  ),
                                  //textAlign: TextAlign.right,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '\nChat with your trainer today \nto arrange a free consultation \nand move a step closer \nto your fitness goals.',
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
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildPageIndicator(),
                          ),
                          SizedBox(height: 20.0),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(30.0),
                              child: RaisedButton(

                                  //color: Colors.lightBlueAccent,
                                  //shape: RoundedRectangleBorder(
                                  //borderRadius: BorderRadius.circular(18.0)),
                                  //: BorderRadius.circular(30.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'GET STARTED',
                                      style: TextStyle(
                                        fontFamily: 'SöhneBreitTest',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  color: Color(0xFF220EE2),
                                  textColor: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side:
                                          BorderSide(color: Color(0xFF220EE2))),
                                  onPressed: () async {
                                    setState(() {
                                      Navigator.pushNamed(
                                          context, RegistrationPage.id);
                                    });
                                  }),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                    DecoratedBox(
                      position: DecorationPosition.background,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage('images/Image 1.jpg'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          Expanded(
                            flex: 1,
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
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'REACH \nGOALS ',
                                  style: TextStyle(
                                    fontFamily: 'SöhneBreitTest',
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 40.0,
                                    color: Colors.white,
                                  ),
                                  //textAlign: TextAlign.right,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '\nSearch by fitness goals, \nschedule the time and location \n- home, work, gym, and pay via the app',
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
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildPageIndicator(),
                          ),
                          SizedBox(height: 20.0),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(30.0),
                              child: RaisedButton(

                                  //color: Colors.lightBlueAccent,
                                  //shape: RoundedRectangleBorder(
                                  //borderRadius: BorderRadius.circular(18.0)),
                                  //: BorderRadius.circular(30.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'GET STARTED',
                                      style: TextStyle(
                                        fontFamily: 'SöhneBreitTest',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  color: Color(0xFF220EE2),
                                  textColor: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side:
                                          BorderSide(color: Color(0xFF220EE2))),
                                  onPressed: () async {
                                    setState(() {
                                      Navigator.pushNamed(
                                          context, RegistrationPage.id);
                                    });
                                  }),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
