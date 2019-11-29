import 'package:flutter/material.dart';
import 'package:yji5/style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yji5/ui/profiledit.dart';
import 'package:yji5/ui/profilregister.dart';
import 'package:yji5/ui/login.dart';
import 'package:yji5/ui/infokes.dart';
import 'package:yji5/ui/infogiat.dart';
import 'package:yji5/app_state_container.dart';
import 'package:yji5/models/app_state.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState  createState() => new HomePageState();
  HomePage({Key key}) : super(key: key);
}

class HomePageState extends State<HomePage> {
  //AppState appState;
  bool visible = false;
  String userNumber = "";
  String verificationID = "";

  getUserProfile() async
  {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    userNumber = await mmkv.getString('phone');
    verificationID = await mmkv.getString('verID');
  }

  resetUserProfile() async
  {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.setString('phone','');
    mmkv.setString('verID','');
  }

  @override
  void initState()
  {
    print("Home initState");
    getUserProfile().then((_){
      print("userNumber $userNumber");
      print("verificationID $verificationID");
    });
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  Widget get _loadingView {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
      return buildPage(context);
  }

  Widget buildPage(BuildContext context) {
    return new Scaffold(
      body: new Container (
        //padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height >= 775.0 ? MediaQuery
                .of(context)
                .size
                .height : 775.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: new Image(
                      width: 191.0,
                      height: 191.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/img/login_yji.png')),
                ),
                SizedBox(height:50.0),
                Text('Welcome to',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontFamily: "WorkSansSemi",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text('Yayasan Jantung Indonesia',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontFamily: "WorkSansSemi",
                  ),
                  textAlign: TextAlign.center,
                ),
                //widget.state.verificationId==null?
                verificationID.isEmpty?Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuLogin(context),
                ):Container(),
                verificationID.isEmpty?Container():Expanded(
                  child: _buildMenu(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuLogin(BuildContext context) {
    return Container(
        child: CustomPaint(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.Colors.bg_menu_home,
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPhonePage()),
                          );
                        },
                        child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontFamily: "WorkSansSemi")
                        )
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.Colors.bg_menu_home,
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPhonePage()),
                          );*/
                          setState(() {
                            resetUserProfile();
                          });
                        },
                        child: Text(
                            "Reset",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontFamily: "WorkSansSemi")
                        )
                    ),
                  ),
                  userNumber.isEmpty?Container():Container(
                      decoration: BoxDecoration(
                        color: Theme.Colors.bg_menu_home,
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          //onPressed: _onSignInButtonPress,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewProfilePage()),
                            ).then((_){
                              setState(() {
                                getUserProfile();
                              });
                            });
                          },
                          child: Text(
                              "Registrasi",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontFamily: "WorkSansSemi")
                          )
                      )
                  )
                ]
            )
        )
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Container(
        child: GridView.count(
          crossAxisCount: 3,
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.Colors.bg_menu_home,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewProfilePage()),
                    );
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.account_box,
                            color: Theme.Colors.icon_home,
                            size:Theme.Colors.icon_size_home),
                        Text("Registrasi",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Theme.Colors.text_size_home,
                                color: Theme.Colors.text_menu_home,
                                fontFamily: Theme.Colors.text_font_home,
                            )
                        )
                      ]
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.Colors.bg_menu_home,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  //onPressed: _onSignInButtonPress,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfogiatPage()),
                    );
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.event,
                        color: Theme.Colors.icon_home,
                        size:Theme.Colors.icon_size_home),
                        Text("Info Kes & Giat",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Theme.Colors.text_size_home,
                              color: Theme.Colors.text_menu_home,
                              fontFamily: Theme.Colors.text_font_home,
                            )
                        )
                      ]
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.Colors.bg_menu_home,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  //onPressed: _onSignInButtonPress,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.assistant,
                            color: Theme.Colors.icon_home,
                            size:Theme.Colors.icon_size_home),
                        Text("Halo Dokter",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Theme.Colors.text_size_home,
                              color: Theme.Colors.text_menu_home,
                              fontFamily: Theme.Colors.text_font_home,
                            )
                        )
                      ]
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.Colors.bg_menu_home,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  //onPressed: _onSignInButtonPress,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.content_paste,
                            color: Theme.Colors.icon_home,
                            size:Theme.Colors.icon_size_home),
                        Text("Registrasi Member",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Theme.Colors.text_size_home,
                              color: Theme.Colors.text_menu_home,
                              fontFamily: Theme.Colors.text_font_home,
                            )
                        )
                      ]
                  )
              ),
            ),
            Container(),
            /*Container(
              decoration: BoxDecoration(
                color: Theme.Colors.bg_menu_home,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  //onPressed: _onSignInButtonPress,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add_call,
                            color: Theme.Colors.icon_home,
                            size:Theme.Colors.icon_size_home),
                        Text("Halo Doctor",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Theme.Colors.text_size_home,
                              color: Theme.Colors.text_menu_home,
                              fontFamily: Theme.Colors.text_font_home,
                            )
                        )
                      ]
                  )
              ),
            ),*/
            Container(
              decoration: BoxDecoration(
                color: Theme.Colors.bg_menu_home,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  //onPressed: _onSignInButtonPress,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.attach_money,
                            color: Theme.Colors.icon_home,
                            size:Theme.Colors.icon_size_home),
                        Text("Donasi",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Theme.Colors.text_size_home,
                              color: Theme.Colors.text_menu_home,
                              fontFamily: Theme.Colors.text_font_home,
                            )
                        )
                      ]
                  )
              ),
            ),
          ],
        )
    );
  }
}
