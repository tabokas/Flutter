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
import 'package:forteapp/bank_data.dart';
import 'package:forteapp/user_profile_init.dart';
import 'package:forteapp/repository.dart';
//import 'package:restcountries/restcountries.dart';

class PaymentLocationPage extends StatefulWidget {
  static const String id = 'paymentlocation_page';
  String usertypevalue;
  PaymentLocationPage({Key key, @required this.usertypevalue})
      : super(key: key);

  @override
  _PaymentLocationPageState createState() =>
      _PaymentLocationPageState(usertypevalue: usertypevalue);
}

class _PaymentLocationPageState extends State<PaymentLocationPage> {
  String usertypevalue;
  _PaymentLocationPageState({this.usertypevalue});

  Repository repo = Repository();

  List<String> _provinces = ["Choose a province"];
  List<String> _cities = ["Choose a city"];

  String _selectedProvince = "Choose a province";
  String _selectedCity = "Choose a city";

  String selectedBank = ' ';
  String selectedAccountType = ' ';
  String selectedCountry = ' ';
  String selectedProvince = 'Gauteng';
  String selectedCity = 'City of Johannesburg Metropolitan Municipality';

  List<DropdownMenuItem> getDropdownBanks() {
    List<DropdownMenuItem<String>> dropdownBanks = [];
    for (String bank in bankList) {
      var newBank = DropdownMenuItem(
        child: Text(bank),
        value: bank,
      );
      //print(bankList[i]);
      print("got banks");
      dropdownBanks.add(newBank);
    }
    return dropdownBanks;
  }

  List<DropdownMenuItem> getDropdownAccountTypes() {
    List<DropdownMenuItem<String>> dropdownAccountTypes = [];
    for (String accountType in accountTypeList) {
      var newAccountType = DropdownMenuItem(
        child: Text(accountType),
        value: accountType,
      );
      //print(bankList[i]);

      dropdownAccountTypes.add(newAccountType);
      print("got accounts");
    }
    return dropdownAccountTypes;
  }

  //locations() async {
  //var api = RestCountries.setup("172190de3d4325a533f68d18e0102ddb");
  // List<Country> countries;
  // List<Region> regions;
  // List<City> cities;
  // countries =
  //    await api.searchCountry(keyword: "South Africa", city: "", region: "");
  // regions = await api.searchRegion(countryCode: "za", city: "", keyword: "");
  // cities = await api.getCities(
  //    countryCode: "za", region: selectedProvince, keyword: "");
  //}

  List<DropdownMenuItem> getDropdownCountries() {
    List<DropdownMenuItem<String>> dropdownCountries = [];
    for (String country in countryList) {
      var newCountry = DropdownMenuItem(
        child: Text(country),
        value: country,
      );
      print("got country");

      dropdownCountries.add(newCountry);
    }
    return dropdownCountries;
  }

  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;
  bool pressAttention = true;
  bool pressText = true;

  //_UserProfileInitPageState(this.userType);

  // TextControllers: All this will be in nice neat classes
  final TextEditingController _accountNumberController =
      new TextEditingController();
  final TextEditingController _branchCodeController =
      new TextEditingController();
  final TextEditingController _nameonCardController =
      new TextEditingController();
  final TextEditingController _typeOfIDController = new TextEditingController();
  final TextEditingController _suburbController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState additional code

    //override for province and city loads
    _provinces = List.from(_provinces)..addAll(repo.getProvinces());

    super.initState();
    getCurrentUser();
  }

  bool showSpinner = false;
  //String email;
  //String password;
  String accountNumber;
  String branchCode;
  String nameonCard;

  String country;

  String typeOfIDString;
  String suburb;

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'ZA';
  PhoneNumber number = PhoneNumber(isoCode: 'ZA');

  DateTime _dateTime;
  DateTime _date = DateTime.now();

  // File imageFile;
  final _picker = ImagePicker();

  //final picker = ImagePicker();

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

  Future<Null> selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1940),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != _date) {
      print(_date.toString());
      setState(() {
        _date = picked;
      });
    }
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
                    onTap: () {
                      //_openGallery();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      //_openCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("build start");
    getDropdownBanks();
    getDropdownAccountTypes();
    //locations();
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
            text: 'Payment \& Location',
            style: TextStyle(
              fontFamily: 'SöhneBreitTest',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.black,
            ),
            // textAlign: TextAlign.center,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        //Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child: Form(
          //inAsyncCall: showSpinner,
          key: _formKey,
          //physics: AlwaysScrollableScrollPhysics(),
          child: ListView(shrinkWrap: true,
              //physics: AlwaysScrollableScrollPhysics(),
              //added alignments
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xFFE5E2FF),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          " Payment partners",
                          //"${widget.usertypevalue}",
                          style: TextStyle(
                            fontFamily: 'SöhneBreitTest',
                            //fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Color(0xFF220EE2),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // _showChoiceDialog(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFEEEEEE),
                          radius: 30.0,
                          child: Icon(
                            Icons.credit_card,
                            semanticLabel: "logo",
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          // _showChoiceDialog(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFEEEEEE),
                          radius: 30.0,
                          child: Icon(
                            Icons.credit_card,
                            semanticLabel: "logo",
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
                    ],
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Text(
                  " Payment info for receiving payments",
                  //"${widget.usertypevalue}",
                  style: TextStyle(
                    fontFamily: 'SöhneBreitTest',
                    //fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Container(
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Bank",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFDDDDDD),
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                      ),
                      value: selectedBank,
                      items: getDropdownBanks(),
                      onChanged: (value) {
                        setState(() {
                          selectedBank = value;
                        });

                        print(value);
                      }),
                ),
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Container(
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Account Type",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFDDDDDD),
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                      ),
                      value: selectedAccountType,
                      items: getDropdownAccountTypes(),
                      onChanged: (value) {
                        setState(() {
                          selectedAccountType = value;
                        });

                        print(value);
                      }),
                ),
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Container(
                  child: TextFormField(
                      controller: _accountNumberController,
                      //validator: validateEmail,
                      onSaved: (value) {
                        accountNumber = value;
                      },
                      //  keyboardType: TextInputType.fullName,
                      decoration: InputDecoration(
                        labelText: "Account Number",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFDDDDDD),
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                  child: TextFormField(
                      controller: _branchCodeController,
                      //validator: validateEmail,
                      onSaved: (value) {
                        branchCode = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Branch Code",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Color(0xffA6A6A6),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFDDDDDD),
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                  child: TextFormField(
                      controller: _nameonCardController,
                      //validator: validateEmail,
                      onSaved: (value) {
                        nameonCard = value;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: "Name on card",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Color(0xffA6A6A6),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFDDDDDD),
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                      )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                ),
                Container(
                  child: Text(
                    "Your location",
                    style: TextStyle(
                      fontFamily: 'SöhneBreitTest',
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                ),
                Container(
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Country",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFDDDDDD),
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                      ),
                      value: selectedCountry,
                      items: getDropdownCountries(),
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                        });

                        print(value);
                      }),
                ),
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Container(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Province",
                      labelStyle: TextStyle(
                        fontFamily: 'SöhneBreitTest',
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFFDDDDDD),
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                    ),
                    value: _selectedProvince,
                    items: _provinces.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) => _onSelectedProvince(value),
                    //value: _selectedProvince,
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Container(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "City",
                      labelStyle: TextStyle(
                        fontFamily: 'SöhneBreitTest',
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFFDDDDDD),
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                    ),
                    value: _selectedCity,
                    items: _cities.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) => _onSelectedCity(value),
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Container(
                  child: TextFormField(
                      controller: _suburbController,
                      //validator: validateEmail,
                      onSaved: (value) {
                        suburb = value;
                      },
                      //  keyboardType: TextInputType.fullName,
                      decoration: InputDecoration(
                        labelText: "Suburb",
                        labelStyle: TextStyle(
                          fontFamily: 'SöhneBreitTest',
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Color(0xFFA6A6A6),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFDDDDDD),
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                  child: SizedBox(
                    width: 5.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),
                Container(
                  child: SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: RaisedButton(
                        child: Text(
                          "SAVE & NEXT",
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
                        onPressed: () async {
                          setState(() {
                            _formKey.currentState.save();
                          } //   showSpinner = true;
                              );

                          await Firestore.instance
                              .collection('users')
                              .document(loggedinuserid)
                              .updateData({
                            'bank': selectedBank,
                            'accounttype': selectedAccountType,
                            'accountnumber': accountNumber,
                            'branchcode': branchCode,
                            'nameoncard': nameonCard,
                            'country': selectedCountry,
                            'province': _selectedProvince,
                            'city': _selectedCity,
                            'suburb': suburb
                          });
                        }),
                  ),
                ),
                Container(
                  child: SizedBox(
                    height: 40.0,
                  ),
                ),
              ]),
        ),
        //)
      ),
    );
  }

  void _onSelectedProvince(String value) {
    setState(() {
      print("running selected province");
      _selectedCity = "Choose ..";
      _cities = ["Choose .."];
      _selectedProvince = value;
      _cities = List.from(_cities)..addAll(repo.getLocalByProvince(value));
    });
  }

  void _onSelectedCity(String value) {
    setState(() => _selectedCity = value);
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'ZA');
    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
