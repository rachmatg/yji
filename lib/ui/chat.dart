import 'package:flutter/material.dart';
import 'package:yji5/style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yji5/ui/login_page.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  .height >= 775.0
                  ? MediaQuery
                  .of(context)
                  .size
                  .height
                  : 775.0,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.Colors.loginGradientStart,
                      Theme.Colors.loginGradientEnd
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 75.0),
                    child: new Image(
                        width: 250.0,
                        height: 191.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/img/login_yji.png')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: _buildMenuLogin(context),
                  ),
                  Expanded(
                    child: _buildMenu(context),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0x552B2B2B),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              //onPressed: _onSignInButtonPress,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.info, color:Colors.white),
                  Text("Info Kesehatan",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontFamily: "WorkSansSemiBold"
                    )
                  )
                ]
              )
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Color(0x552B2B2B),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                //onPressed: _onSignInButtonPress,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.event, color:Colors.white),
                      Text("Info Kegiatan",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontFamily: "WorkSansSemiBold"
                          )
                      )
                    ]
                )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0x552B2B2B),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                //onPressed: _onSignInButtonPress,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.assistant, color:Colors.white),
                      Text("Bantuan",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontFamily: "WorkSansSemiBold"
                          )
                      )
                    ]
                )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0x552B2B2B),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                //onPressed: _onSignInButtonPress,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.content_paste, color:Colors.white),
                      Text("Periksa Sendiri",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontFamily: "WorkSansSemiBold"
                          )
                      )
                    ]
                )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0x552B2B2B),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                //onPressed: _onSignInButtonPress,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_call, color:Colors.white),
                      Text("Halo Doctor",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontFamily: "WorkSansSemiBold"
                          )
                      )
                    ]
                )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0x552B2B2B),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                //onPressed: _onSignInButtonPress,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.attach_money, color:Colors.white),
                      Text("Mari Membantu",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontFamily: "WorkSansSemiBold"
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

  Widget _buildMenuLogin(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Container(
              decoration: BoxDecoration(
                color: Color(0x552B2B2B),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: "WorkSansSemiBold")
                )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0x552B2B2B),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                //onPressed: _onSignInButtonPress,
                child: Text(
                    "Daftar",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: "WorkSansSemiBold")
                )
              )
            )
          ]
        )
      )
    );
  }


}
