import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forteapp/coach_profiles_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:forteapp/user_profile_init.dart';
import 'package:flutter/gestures.dart';
import 'package:forteapp/login_page.dart';
import 'package:path/path.dart';
import 't_c_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forteapp/user_profile_init.dart';

enum TypeOfUser { athlete, instructor }
TypeOfUser selectedUser;

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
  String confirmpassword;
  //bool _isSelected = false;

  String TypeOfUserString;

  String _error;
  //validators
  final GlobalKey<FormState> _key = new GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();
  final TextEditingController _mobileController = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool visible = true;
  // bool pressAttention = false;
  // bool pressText = false;
  bool _termsChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int athleteColor = 0xFF9E9E9E;
    int coachColor = 0xFF9E9E9E;
//0xFF000000 black  0xFFFFFFFF  white      0x3DFFFFFF white 12/   0xFF424242    grey 0xFF9E9E9E
    //theme:
    //ThemeData(unselectedWidgetColor: Colors.grey);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/group-5@2x.png',
              fit: BoxFit.contain,
              height: 20,
            ),
            // Container(padding: const EdgeInsets.all(1.0),
            //    child: Text(''))
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
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child: Form(
          key: _formKey,
          // was key: _key
          autovalidate: _validate,
          child: ListView(
            //added alignments
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Padding(
                          //   padding: EdgeInsets.only(top: 5.0),
                          // ),
                          SizedBox(
                            height: 40.0,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'GET STARTED',
                              style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.black,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 5.0),
                    // ),
                    SizedBox(
                      height: 46.0,
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Are you an athlete or an instructor?",
                  style: TextStyle(
                    fontFamily: 'SöhneBreitTest',
                    // fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                //mainAxisSize: MediaQuery.of(context).size.width * 0.8,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ButtonTheme(
                      height: 40,
                      child: RaisedButton(
                        //shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(18.0)),
                        //: BorderRadius.circular(30.0),
                        onPressed: () {
                          setState(() {
                            //   athleteColor = 0xFFFFFFFF;
                            //   coachColor = 0xFF9E9E9E;
                            print("athlete clicked");
                            TypeOfUserString = "Athlete";
                            print(TypeOfUserString);
                            // pressAttention = true;
                            // pressText = true;
                            // highlightColor:
                            // Color(athleteColor);
                            selectedUser = TypeOfUser.athlete;
                          });
                        },
                        // highlightColor: Color(athleteColor),
                        color: selectedUser == TypeOfUser.athlete
                            ? Colors.black
                            : Color(0xFFEEEEEE),
                        child: Text(
                          "ATHLETE",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            //color: Color(0xFF220EE2),
                          ),
                        ),
                        //color: Color(athleteColor),
                        textColor: selectedUser == TypeOfUser.athlete
                            ? Colors.white
                            : Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          // side: BorderSide(color: Color(0xFFEEEEEE))
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: ButtonTheme(
                      height: 40,
                      child: RaisedButton(
                        //color: Color(coachColor),
                        //shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(18.0)),
                        //: BorderRadius.circular(30.0),
                        onPressed: () {
                          setState(() {
                            TypeOfUserString = "Instructor";
                            print("instructor clicked");
                            print(TypeOfUserString);
                            // pressAttention = false;
                            // pressText = true;
                            // coachColor = 0xFFFFFFFF;
                            // athleteColor = 0xFF9E9E9E;
                            // toggleUser(TypeOfUser.coach);
                            selectedUser = TypeOfUser.instructor;
                          });
                        },
                        color: selectedUser == TypeOfUser.instructor
                            ? Colors.black
                            : Color(0xFFEEEEEE),
                        child: Text(
                          "INSTRUCTOR",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            // color: Color(0xFF220EE2),
                          ),
                        ),
                        // color: Color(coachColor),
                        textColor: selectedUser == TypeOfUser.instructor
                            ? Colors.white
                            : Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          // side: BorderSide(color: Color(0xFFEEEEEE))
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 5.0,
                  // ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  onSaved: (value) {
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
                  controller: _passwordController,
                  validator: validatePassword,
                  onSaved: (value) {
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
              TextFormField(
                  controller: _confirmPasswordController,
                  validator: (confirmation) {
                    return confirmation.isEmpty
                        ? 'Confirm password is required'
                        : validationEqual(
                                confirmation, _passwordController.text)
                            ? null
                            : 'Password not match';
                  },
                  onSaved: (value) {
                    confirmpassword = value;
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
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      // fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Colors.black,
                    ),
                  )),
              // Container(
              //   padding: EdgeInsets.all(5.0),
              // ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // terms and conditions checkbox, changed checkbox to checkboxlistTile.

                    Expanded(
                      // child: MyTermsAndConditions(),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Color(0xFFDDDDDD),
                        checkColor: Color(0xFF220EE2),
                        title: Text('I accept the terms and conditions',
                            style: TextStyle(
                                fontFamily: 'SöhneBreitTest',
                                fontSize: 10.0,
                                color: Colors.black)),
                        value: _termsChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _termsChecked = value;
                          });
                          _showDialog(context);
                        },
                        subtitle: !_termsChecked
                            ? Text(
                                'Please accept the terms and conditions',
                                style: TextStyle(
                                    color: Color(0xFFe53935), fontSize: 12),
                              )
                            : null,
                      ),
                    )
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: Card(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: RaisedButton(
                              child: Text(
                                "CREATE ACCOUNT",
                                style: TextStyle(
                                  fontFamily: 'SöhneBreitTest',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
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
                              onPressed: () async {
                                print("clicked");
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  print("some valid stuff right here");
                                  // } else {
                                  setState(() {
                                    print("this ran anyway");
                                    _validate = true;
                                    showSpinner = true;
                                  });
                                  try {
                                    print(email);
                                    print(password);

                                    final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                    if (newUser != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfileInitPage(
                                                    usertypevalue: TypeOfUserString,
                                                  )));
                                    }
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  } catch (e) {
                                    e.toString().contains(
                                        'The email address is already in use')
                                        ? _error =
                                    'The email address is already in use by another account.'
                                        : _error = e.toString();
                                    final snackBar =
                                    SnackBar(content: Text('$_error'));
                                    scaffoldKey.currentState.showSnackBar(snackBar);
                                    //Scaffold.of(context).showSnackBar(
                                    // SnackBar(content: Text('$_error')));
                                    print(e);
                                  }
                                }
                              }),
                        ),
                      ),
                    )
                  ]),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: TextSpan(
                        text: 'Already a member? ',
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
                          text: 'Sign in',
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //TODO link to email password
                              Navigator.pushNamed(context, LoginPage.id);
                            }),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// class LinkedLabelCheckbox extends StatelessWidget {
//   const LinkedLabelCheckbox({
//     this.label,
//     this.padding,
//     this.value,
//     this.onChanged,
//   });

//   final String label;
//   final EdgeInsets padding;
//   final bool value;
//   final Function onChanged;

//   @override
//   Widget build(BuildContext context) {
//     theme:
//     ThemeData(unselectedWidgetColor: Colors.grey);
//     return Padding(
//       padding: padding,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Checkbox(
//             focusColor: Colors.white,
//             activeColor: Colors.grey,
//             checkColor: Color(0xFF220EE2),
//             value: value,
//             onChanged: (bool newValue) {
//               onChanged(newValue);
//             },
//           ),
//           RichText(
//             text: TextSpan(
//               text: "I accept the ",
//               style: TextStyle(
//                   fontFamily: 'SöhneBreitTest',
//                   fontSize: 12.0,
//                   color: Colors.black),
//             ),
//           ),
//           RichText(
//             text: TextSpan(
//               text: label,
//               style: TextStyle(
//                 fontFamily: 'SöhneBreitTest',
//                 fontSize: 12.0,
//                 color: Colors.black,
//                 decoration: TextDecoration.underline,
//               ),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () {
//                   Navigator.pushNamed(context, TCPage.id);

//                   print('Label has been tapped.');
//                 },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Terms and conditions dialog (pop up)

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog

          return AlertDialog(
            title: new Text("Terms and Conditions"),
            content: Container(
              height: 600,
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // SizedBox(
                    //     // height: 20,
                    //     ),
                    Text(
                        "''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut volutpat ipsum sit amet malesuada varius. Ut fringilla augue nec lacus volutpat convallis. Aliquam sed nisl at nisi volutpat interdum. Donec vel est dignissim, ullamcorper sapien ac, pretium nisl. Proin faucibus magna nisl, ut aliquet metus suscipit vel. Etiam dignissim nibh posuere purus lobortis, ultricies fermentum ante rhoncus. Duis laoreet ligula eu laoreet finibus. Integer pulvinar accumsan sem, vitae feugiat elit tincidunt eu. Nullam tempor elementum elit, molestie ultrices augue ullamcorper nec. Etiam leo dui, commodo id aliquet pretium, vestibulum sed mauris. Phasellus nulla lorem, dignissim in libero nec, venenatis sagittis metus. In interdum sapien ut velit lobortis varius. In ultrices hendrerit lectus, non sagittis metus bibendum non. Suspendisse ex tortor, semper sit amet sem a, malesuada molestie eros."
                        '''
Integer at mi luctus lectus mollis iaculis. Sed auctor est eget consequat aliquam. Donec ut velit eros. Sed congue et nulla nec molestie. Donec in est eu risus pulvinar efficitur. Donec at volutpat mi. Sed vitae dapibus nunc. Phasellus eu commodo tellus, ut hendrerit urna. Ut a odio tempor, eleifend tortor at, dictum enim. Pellentesque faucibus arcu non odio auctor, id posuere metus varius. Etiam pulvinar est mauris, ut rutrum ipsum suscipit eget. Integer lacinia, libero sit amet congue molestie, ante nisi hendrerit est, at finibus ex leo congue odio'''
                        "Nunc eu nisl ut purus elementum aliquam ut sit amet risus. Maecenas congue nisi a ipsum porttitor condimentum in ut dolor. Donec in turpis quis massa cursus suscipit. Ut ullamcorper tortor quis ex efficitur, eget condimentum ex placerat. Nulla in venenatis libero. Curabitur risus lacus, rutrum varius feugiat consectetur, pharetra sit amet tellus. Sed metus massa, interdum quis arcu a, rutrum congue purus. Suspendisse enim tellus, bibendum sit amet arcu et, egestas vulputate neque."
                        '''
Duis diam enim, venenatis a sapien ut, pellentesque blandit orci. Pellentesque sit amet est nec nunc sodales laoreet eu quis nibh. Duis leo erat, ullamcorper et luctus nec, sodales ac dui. Pellentesque hendrerit tincidunt lectus vel hendrerit. Praesent sollicitudin dapibus lacus vitae consequat. In consectetur commodo interdum. Etiam quis porttitor est. Donec pulvinar lorem sit amet felis cursus, in venenatis ex placerat. Cras fringilla, eros eget auctor mollis, mi felis lacinia purus, et consectetur velit nunc nec diam.'''
                        '''
Morbi et lacinia elit. Phasellus diam urna, tempor nec nulla nec, fermentum hendrerit nisi. Aenean cursus id tortor in tristique. Vivamus aliquet, est eu blandit dignissim, nulla sapien mollis nisl, vel bibendum enim justo pharetra dui. Suspendisse dignissim viverra turpis in luctus. Aliquam varius diam leo, vel cursus purus ultricies sit amet. In vel pharetra diam. Fusce interdum tincidunt ex, eget maximus risus gravida ac. Sed consectetur id justo et sodales.'''
                        '''
Aliquam cursus pretium aliquet. Praesent ex nisl, mollis eget urna vitae, malesuada varius odio. Nullam tincidunt lectus eget purus auctor vestibulum. Nulla pulvinar felis sit amet mi sollicitudin lacinia. Nunc maximus mauris in nunc ullamcorper, ut porttitor diam bibendum. Cras nec arcu tincidunt, gravida dui id, accumsan sem. Integer suscipit neque non tellus faucibus vulputate.'''
                        '''
Sed posuere id velit quis sagittis. Maecenas finibus felis et lacinia scelerisque. Mauris at imperdiet diam. Aenean non laoreet urna. Proin sodales lacinia urna, in porttitor dui. Etiam erat dui, placerat non lorem at, tincidunt placerat sapien. Cras viverra nulla ac massa venenatis laoreet. Curabitur laoreet rutrum volutpat. Suspendisse faucibus finibus ultrices. Quisque vel velit sed ligula gravida vehicula. Duis molestie viverra viverra. Nullam semper velit ornare eros vestibulum, ac porta nisi dignissim'''
                        '''
Praesent vitae mattis tellus. Praesent tristique, leo in maximus maximus, elit libero interdum augue, eget aliquam ex odio et leo. Donec non bibendum metus. Aenean ac molestie quam, eget luctus tortor. Maecenas at tellus id magna tincidunt sollicitudin a in dolor. Quisque eget tempor massa. Donec non malesuada mauris. Mauris mollis, massa eu vehicula ultrices, magna elit luctus lectus, vel feugiat purus erat eget sapien. Praesent cursus lobortis ex, quis fermentum felis varius et. Nam at aliquam nulla, quis laoreet mi. Vivamus eget ex sem. Nam et neque tristique risus placerat facilisis ut a nisl. Nulla elementum mattis erat. Phasellus feugiat, lectus vitae sagittis viverra, mi dui imperdiet erat, vitae mollis justo libero sed sapien'''
                        '''
Mauris at lacus volutpat, accumsan turpis quis, porta neque. Nunc vitae lorem arcu. Integer dui sapien, sodales vitae interdum a, suscipit ac magna. Nulla efficitur massa nec varius hendrerit. Curabitur quis nulla mi. Phasellus ultrices id libero sit amet accumsan. Vivamus a felis vitae sem pharetra mollis et at dolor. Fusce quis nulla risus'''
                        '''
Quisque dictum porttitor nisl in molestie. Nullam at lacinia sem, non congue diam. Quisque vel bibendum erat. Ut et scelerisque ipsum, et porta quam. Etiam id augue tincidunt diam venenatis fringilla sed vel sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed sapien pellentesque, aliquet dolor et, sollicitudin orci. Vivamus non quam eget lorem scelerisque facilisis at vitae metus. Aliquam erat volutpat.Proin eleifend, augue at porta tincidunt, sem erat cursus dolor, suscipit feugiat nulla ligula at lorem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec vehicula consectetur diam, a porttitor leo fringilla scelerisque. Proin lacinia sagittis quam, id ultricies lorem faucibus non. Morbi vestibulum gravida efficitur. Aliquam quis fringilla leo. Aliquam a neque in diam pulvinar maximus et vitae ante. Vivamus lacinia, sem quis maximus sodales, erat massa eleifend eros, nec consequat massa dui et risus. Nullam ac mi non velit vehicula egestas non ac mauris. Aliquam erat volutpat. Nulla facilisi. Curabitur ipsum sapien, rhoncus feugiat venenatis nec, posuere id ex. In ut mauris id ex accumsan accumsan. Duis sem massa, porttitor a nulla et, bibendum pellentesque risus. Maecenas et aliquet nibh.'''
                        " Etiam sollicitudin, nibh ut consequat dapibus, felis metus varius velit, non pellentesque nulla velit non sem. Aenean facilisis, neque ac rhoncus suscipit, metus eros suscipit tellus, luctus euismod libero tellus eget ligula. Quisque ut lobortis mi. Fusce imperdiet dapibus tellus sed condimentum. Suspendisse lacinia placerat dui eget accumsan. Integer vitae porttitor lectus, eu condimentum nisl. Nam in nunc a ante consequat scelerisque. Mauris ultricies purus sit amet nunc sodales, ac gravida est lobortis."
                        "Etiam placerat vitae erat eget rutrum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed mollis ipsum sed urna pulvinar, vestibulum ultricies erat feugiat. Pellentesque eget eros aliquam, vulputate metus ut, lacinia neque. Nunc molestie tincidunt dignissim. Suspendisse pharetra metus risus, nec interdum odio scelerisque tristique. Sed purus eros, efficitur nec dolor sit amet, feugiat fringilla elit. Pellentesque dapibus augue elit, ut rutrum orci mattis nec. Quisque quis arcu fringilla elit tincidunt efficitur. Etiam sodales magna sit amet nunc elementum consectetur."
                        """
 Nam iaculis sem id finibus gravida. Vivamus non massa leo. Pellentesque facilisis eros nec neque iaculis suscipit. Mauris tincidunt nibh nibh. Vestibulum in finibus velit. Aenean sit amet risus lorem. Proin congue semper metus non venenatis. In hac habitasse platea dictumst. Sed sollicitudin justo vehicula commodo malesuada. Aenean purus ante, pharetra et dignissim condimentum, semper a mi. Integer elementum sapien vel mi gravida, in porttitor lacus pharetra. Aenean sed nunc metus"""
                        """
 Cras posuere scelerisque rhoncus. Nullam tempor iaculis porta. Mauris feugiat, ex eget semper lacinia, purus sem pretium risus, vel aliquet diam erat sed arcu. Integer placerat tristique dui blandit pharetra. Mauris sit amet tempus nunc. Nullam tortor lacus, iaculis eu ultricies sed, tincidunt quis tortor. Etiam volutpat nibh in leo varius, at feugiat augue lacinia. Sed commodo tempus malesuada. Mauris vel tincidunt velit. Phasellus lacinia rhoncus sapien a interdum. Interdum et malesuada fames ac ante ipsum primis in faucibus."""
                        " Cras cursus ligula neque, et venenatis purus lobortis ut. Aenean molestie urna sed enim laoreet sodales. Maecenas vehicula tristique purus eu imperdiet. Pellentesque ullamcorper nisi lorem, eget pellentesque erat aliquet nec. Fusce ut justo at nisi placerat tempor. Aliquam accumsan ex eu mollis consectetur. Aliquam rhoncus auctor quam quis maximus. Proin in lacus condimentum, faucibus est at, eleifend erat. Nam dictum, justo in consequat porttitor, nibh massa eleifend augue, id ultricies odio tortor quis elit. Etiam sagittis nec magna nec maximus. Maecenas id lobortis turpis, eleifend maximus urna. Maecenas sit amet leo id tellus vehicula consequat. Proin nisl nulla, pellentesque sed risus rhoncus, laoreet congue lacus."
                        " Ut porta non sem sit amet posuere. Donec eu massa et dui tincidunt accumsan. Pellentesque ac finibus leo. Morbi quis consequat purus, et molestie leo. Maecenas eros odio, suscipit id accumsan ut, ultricies malesuada nunc. Suspendisse vehicula lacus sit amet leo sagittis auctor. Etiam pulvinar eleifend viverra. Vivamus a maximus lorem, ac facilisis erat."
                        "Maecenas ullamcorper condimentum magna. Phasellus porta lacinia pellentesque. Duis et erat bibendum, porta justo ut, suscipit diam. Integer porttitor convallis iaculis. Fusce eget rutrum massa. Morbi sollicitudin auctor nisl nec eleifend. Mauris ac lacus nec tellus elementum euismod ut id elit. Pellentesque ullamcorper ultricies metus vel faucibus. Vestibulum dignissim dignissim eros quis aliquet. Sed lobortis ligula in libero placerat, et hendrerit tortor aliquam. Donec eu purus dui. In ultrices ex eu facilisis eleifend. Praesent condimentum odio risus, vel suscipit est ultricies vel. Quisque elementum pharetra sollicitudin."
                        " Curabitur vitae massa ut velit tristique mattis at sit amet ipsum. Nullam lacinia enim erat, nec convallis nulla lacinia at. Cras posuere lacus vel nibh rutrum accumsan. Donec cursus pellentesque nisl in malesuada. Curabitur quis varius orci. Morbi pulvinar in massa eu pretium. Proin venenatis lacinia nulla, eget hendrerit urna. Etiam facilisis, arcu eu semper rhoncus, eros velit consequat diam, eu consectetur diam nisi eget ligula. Sed ornare felis laoreet, placerat est et, lobortis mauris. Curabitur eget nisl nec tortor facilisis egestas.'"
                        """
Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus."""
                        '''
Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi.'''
                        '''
Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo.'''
                        'Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.'
                        '''
Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus.'''
                        '''
 Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi.'''
                        'Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo.'
                        'Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.'
                        'Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus.'
                        'Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi.'
                        'Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo.'
                        'Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.'
                        ' Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus.'
                        'Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi.'
                        ' Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo.'
                        'Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.'
                        'Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus.'
                        ' Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi.'
                        'Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo.'
                        'Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.'
                        'Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus.'
                        'Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi.'
                        'Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo.'
                        'Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.'
                        ',Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus.'
                        'Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi.'
                        'Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo.'
                        '''
Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.'''
                        ' Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus.'
                        'Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi.'
                        ' Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo.'
                        'Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.'
                        ' Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus.'
                        """
 Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi."""
                        """
 Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo."""
                        """
Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna."""
                        """
 Fusce nec ullamcorper justo, id porta lectus. Vivamus eu tellus libero. Vestibulum congue sagittis ornare. Aenean nisl augue, pellentesque consectetur luctus vitae, scelerisque ut lorem. In tincidunt facilisis dolor nec varius. Sed eu rhoncus lorem, quis consequat metus. Donec ante diam, porttitor at finibus sit amet, tempor a dolor. Vivamus dapibus vel purus ac convallis. Duis nec maximus tortor. Etiam vel varius lacus. In eu turpis vel quam sodales lacinia in et sapien. Proin gravida sem at nisi egestas, at feugiat lacus laoreet. Vestibulum ac ex auctor, sollicitudin lorem eget, feugiat neque. Integer facilisis diam sed nibh pharetra finibus."""
                        """
Morbi facilisis orci sed egestas tempor. Vestibulum malesuada, lacus sit amet aliquam pulvinar, massa libero commodo velit, vitae vulputate nisl felis et augue. Quisque dictum diam sed urna maximus, id vehicula sem efficitur. Etiam quis commodo lacus. Maecenas vehicula velit vel ante posuere, in hendrerit magna aliquet. Aenean interdum lorem magna, eget ullamcorper urna consectetur eget. Cras sit amet laoreet odio. Suspendisse eleifend dapibus nibh, commodo pellentesque elit accumsan eu. Aenean scelerisque urna ex, vitae consequat justo mattis et. Maecenas vitae semper arcu, ut tincidunt mi."""
                        "  Maecenas nec ullamcorper odio, at venenatis mi. Pellentesque eu libero ac elit efficitur lobortis quis in lacus. Integer quis nisl ac sapien fringilla molestie vestibulum non nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus mattis vel ex vel venenatis. Praesent commodo augue vel placerat dapibus. Donec eget varius dolor. Vivamus pharetra, justo ac iaculis tincidunt, tortor erat rutrum turpis, eu scelerisque metus lectus at mi. Pellentesque vehicula, libero tempus fermentum malesuada, turpis diam tincidunt enim, id dapibus quam tellus sit amet nunc. Duis mauris leo, finibus sed ultrices sit amet, bibendum id ante. In eget nibh et nunc feugiat pretium at et justo."
                        "Aenean ultricies condimentum tincidunt. Maecenas sit amet consequat magna. Etiam ut ante in dolor auctor gravida at id nunc. Vestibulum vulputate orci id sapien ornare ornare. Vestibulum fringilla eros est, eget vehicula tortor mollis eu. Suspendisse vitae vehicula tortor, vel mattis mi. Duis iaculis scelerisque posuere. Nam dictum sodales lacus. Pellentesque quis eros nec ex accumsan aliquam. Cras ac augue ante. Duis sollicitudin augue eget finibus pulvinar. Suspendisse nisl erat, tincidunt at turpis ornare, vulputate pellentesque magna.  ",
                        style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            fontSize: 10.0,
                            height: 1.6,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Confirm password is required';
    } else if (value.length < 6) {
      return 'Confirm password must be at least 4 characters';
    }
    return null;
  }

  bool validationEqual(String currentValue, String checkValue) {
    if (currentValue == checkValue) {
      return true;
    } else {
      return false;
    }
  }
// class MyTermsAndConditions extends StatefulWidget {
//   MyTermsAndConditions({Key key}) : super(key: key);

//   @override
//   _MyTermsAndConditions createState() => _MyTermsAndConditions();
// }

// class _MyTermsAndConditions extends State<MyTermsAndConditions> {
//   bool _isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return LinkedLabelCheckbox(
//       label: 'terms and conditions',
//       padding: const EdgeInsets.symmetric(horizontal: 1.0),
//       value: _isSelected,
//       onChanged: (bool newValue) {
//         setState(() {
//           _isSelected = newValue;
//         });
//       },
//     );
//   }
// }
}

class PassUserType {
  final String userType;

  PassUserType(this.userType);
}
