import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/login.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';

import 'models/app_state.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

class AppStateContainer extends StatefulWidget {
  final AppState state;
  final Widget child;

  AppStateContainer({
    @required this.child,
    this.state,
  });

  // This creates a method on the AppState that's just like 'of'
  // On MediaQueries, Theme, etc
  // This is the secret to accessing your AppState all over your app
  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
    as _InheritedStateContainer)
        .data;
  }

  @override
  _AppStateContainerState createState() => new _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  AppState state;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      state.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      state.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print('verified');
    };
    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: state.phoneNo,
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
                state.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/');
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/infokes');
                    }
                  });
                },
              )
            ],
          );
        });
  }

  Future<String> _getTokenID() async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    return await mmkv.getString('tokenKey');
  }

  void getLogic() async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    String Token = await mmkv.getString('tokenKey');
    if (Token == "") {
      print ("Token is null");
      print ("Harus login dulu");
      await mmkv.setString('tokenKey',"12345");
      MaterialPageRoute(
          builder: (context) => LoginPhonePage());
    }
    else {
      print(Token);
      MaterialPageRoute(
          builder: (context) => LoginPhonePage());
    }
  }

  @override
  void initState() {
    super.initState();
    getLogic();
  }

  Future<Null> startCountdown() async {
    const timeOut = const Duration(seconds: 2);
    new Timer(timeOut, () {
      setState(() => state.isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}