import 'package:flutter/material.dart';
import 'package:jaycar_mobile_app/navbar.dart';

//IDEAS:
//have it so that when you click description sets to true, then when click on another sets false and then loads that module thingy :)
//Tidy it up a bit and a basic prototype is made lol.

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  /// ↓↓ ADDED
  /// InheritedWidget style accessor to our State object.
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

Map<int, Color> primarycolor = {
  50: const Color.fromRGBO(12, 37, 76, .1),
  100: const Color.fromRGBO(12, 37, 76, .2),
  200: const Color.fromRGBO(12, 37, 76, .3),
  300: const Color.fromRGBO(12, 37, 76, .4),
  400: const Color.fromRGBO(12, 37, 76, .5),
  500: const Color.fromRGBO(12, 37, 76, .6),
  600: const Color.fromRGBO(12, 37, 76, .7),
  700: const Color.fromRGBO(12, 37, 76, .8),
  800: const Color.fromRGBO(12, 37, 76, .9),
  900: const Color.fromRGBO(12, 37, 76, 1),
};
Map<int, Color> primarydarkcolor = {
  50: const Color.fromRGBO(187, 134, 252, .1),
  100: const Color.fromRGBO(187, 134, 252, .2),
  200: const Color.fromRGBO(187, 134, 252, .3),
  300: const Color.fromRGBO(187, 134, 252, .4),
  400: const Color.fromRGBO(187, 134, 252, .5),
  500: const Color.fromRGBO(187, 134, 252, .6),
  600: const Color.fromRGBO(187, 134, 252, .7),
  700: const Color.fromRGBO(187, 134, 252, .8),
  800: const Color.fromRGBO(187, 134, 252, .9),
  900: const Color.fromRGBO(187, 134, 252, 1),
};
MaterialColor primarycolourscheme = MaterialColor(0xFF6200EE, primarycolor);
MaterialColor primarydarkcolourscheme = MaterialColor(0xFFBB86FC, primarycolor);

class _MyAppState extends State<MyApp> {
  /// 1) our themeMode "state" field
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
          primarySwatch: primarycolourscheme,
          primaryColor: const Color.fromRGBO(12, 37, 76, 1),
          brightness: Brightness.light,
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          dividerColor: const Color.fromRGBO(217, 217, 217, 1),
          appBarTheme: const AppBarTheme(color: Color.fromRGBO(12, 37, 76, 1))),

      darkTheme: ThemeData(
          primarySwatch: primarydarkcolourscheme,
          primaryColor: const Color.fromRGBO(30, 30, 30, 1),
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF121212),
          dividerColor: Colors.black12,
          appBarTheme: const AppBarTheme(
            color: Color.fromRGBO(55, 0, 179, 1),
          )),

      themeMode: _themeMode, // 2) ← ← ← use "state" field here //////////////
      home: const PersistantBar(),
    );
  }

  /// 3) Call this to change theme from any context using "of" accessor
  /// e.g.:
  /// MyApp.of(context).changeTheme(ThemeMode.dark);
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
