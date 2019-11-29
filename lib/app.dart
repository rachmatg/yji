import 'package:flutter/material.dart';
import 'ui/login_page.dart';
import 'ui/home.dart';
import 'ui/infokes.dart';

class AppRootWidget extends StatefulWidget {
  @override
  AppRootWidgetState createState() => new AppRootWidgetState();
}

class AppRootWidgetState extends State<AppRootWidget> {
  ThemeData get _themeData => new ThemeData(
    primaryColor: Colors.cyan,
    accentColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[300],
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Inherited',
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      routes: {
        '/': (BuildContext context) => new HomePage(),
        '/auth': (BuildContext context) => new LoginPage(),
        '/infokes': (BuildContext context) => new InfokesPage(),
      },
    );
  }
}