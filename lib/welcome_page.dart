import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registration_page.dart';

int _lowerCount = -1;
int _upperCount = 1;

class WelcomePage extends StatelessWidget {
  static const String id = 'welcome_page';

  final List<Widget> _pages = <Widget>[
    Scaffold(
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Image(
                    image: AssetImage('images/TrainingImage1.jpg'),
                    width: 200,
                    height: 420,
                    fit: BoxFit.fill),
              ),
              ListTile(
                  //padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  title: Text(
                    'Find Your Personal Trainer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Our hand picked trainers can take you from novice to pro. Based on their experience, they are able to tailor programs that fit your lifestyle and produce results that leave you feeling great.',
                      textAlign: TextAlign.center,
                    ),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(165, 10, 165, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.pink,
                      ),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  )),
              Container(
                //alignment: Alignment.centerLeft,
                //height: 500,
                //width: 800,
                margin: EdgeInsets.only(bottom: 10),
              ),
            ],
          ),
        ),
      ),
    ),
    Scaffold(
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Image(
                    image: AssetImage('images/TrainingImage1.jpg'),
                    width: 200,
                    height: 420,
                    fit: BoxFit.fill),
              ),
              ListTile(
                  //padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  title: Text(
                    'Train To Reach Your Personal Goals',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Chat with your trainer today to arrange a free consultation and move a step closer to your fitness goals',
                      textAlign: TextAlign.center,
                    ),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(165, 10, 165, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.pink,
                      ),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  )),
              Container(
                //alignment: Alignment.centerLeft,
                //height: 500,
                //width: 800,
                margin: EdgeInsets.only(bottom: 10),
              ),
            ],
          ),
        ),
      ),
    ),
    Scaffold(
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Image(
                    image: AssetImage('images/TrainingImage2.jpeg'),
                    width: 200,
                    height: 420,
                    fit: BoxFit.fill),
              ),
              ListTile(
                  //padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  title: Text(
                    'Book Sessions When And Where You Want',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Search by fitness goals, schedule the time and location - home, work, gym, and pay via the app',
                      textAlign: TextAlign.center,
                    ),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(165, 10, 165, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.grey,
                      ),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.pink,
                      ),
                    ],
                  )),
              Container(
                //alignment: Alignment.centerLeft,
                //height: 500,
                //width: 800,
                margin: EdgeInsets.only(bottom: 10),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
                image: AssetImage('images/TrainingImage2.jpeg'),
                fit: BoxFit.cover)),
        child: PageView(
          onPageChanged: (pageId) {
            if (pageId == _pages.length - 1) {
              _upperCount = _upperCount + 1;
            }
            if (pageId == 0) {
              _lowerCount = _lowerCount - 1;
            }
          },
          controller: PageController(
            initialPage: -1,
          ),
          children: _pages,
        ),
      ),
      bottomNavigationBar: new Stack(children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: SizedBox(
            width: 165,
            child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationPage.id);
                },
                child: const Text('Sign Up', style: TextStyle(fontSize: 20)),
                color: Colors.pink,
                textColor: Colors.white,
                elevation: 5,
                shape: StadiumBorder()),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(200, 0, 0, 0),
          child: SizedBox(
            width: 165,
            child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                  // Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text('Sign In', style: TextStyle(fontSize: 20)),
                color: Colors.pink,
                textColor: Colors.white,
                elevation: 5,
                shape: StadiumBorder()),
          ),
        ),
      ]),
    );
  }

  Future navigateToLoginPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
