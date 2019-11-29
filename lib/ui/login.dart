import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../style/theme.dart' as Theme;
//import 'package:yji5/utils/bubble_indication_painter.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:yji5/app_state_container.dart';
import 'package:yji5/models/app_state.dart';
import 'home.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';

class LoginPhonePage extends StatefulWidget {

  @override
  _LoginPhonePageState createState() => new _LoginPhonePageState();
  AppState state;
  LoginPhonePage({Key key, @required this.state}) : super(key: key);

}

class _LoginPhonePageState extends State<LoginPhonePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeMobileLogin = FocusNode();

  TextEditingController loginMobileController = new TextEditingController();

  String userNumber = "";
  String verificationID = "";

  Color left = Colors.black;
  Color right = Colors.white;
  String smsCode;

  getUserProfile() async
  {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    userNumber = await mmkv.getString('phone');
    verificationID = await mmkv.getString('verID');
  }
  @override
  void initState()
  {
    print("Login initState");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getUserProfile().then((_){
      print("userNumber $userNumber");
      loginMobileController.text = userNumber;
    });
    super.initState();
  }

  @override
  void dispose() {
    myFocusNodeMobileLogin.dispose();
    loginMobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Image(
                          width: 191.0,
                          height: 191.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/img/login_yji.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: _buildSignIn(context),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }


  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
  //                width: 300.0,
//                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeMobileLogin,
                          controller: loginMobileController,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            //widget.state.phoneNo = value;
                            //print("Masukkan nomor HP");
                          },
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            //prefixText: '+62',
                            labelText: 'Nomor HP',
                            hasFloatingPlaceholder: true,
                            labelStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0, color: Colors.black),
                            icon: Icon(
                              FontAwesomeIcons.mobile,
                              color: Colors.black,
                              size: 22.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {
//                      widget.state.phoneNo = loginMobileController.text;
                      verifyPhone();
                    },
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationID = verId;
      print('Timeout');
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      //widget.state.verificationId = verId;
      print(verId);
      setState(() {
        this.verificationID = verId;
      });
      smsCodeDialog(context);
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print('verified');
    };


    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    print('Nunggu Firebase verify phone ' + loginMobileController.text);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: loginMobileController.text,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () {
                  signIn().then((_){
                    Navigator.pop(context);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool>  signIn() async {
    print(this.smsCode);
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: this.verificationID,
      smsCode: this.smsCode,
    );
    final _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user.uid == currentUser.uid) {
      return true;
    }
    else return false;
  }

}
