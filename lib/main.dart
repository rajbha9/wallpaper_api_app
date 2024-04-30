import 'package:flutter/material.dart';
import 'package:wallpaper_api_app/views/homepage.dart';
import 'package:wallpaper_api_app/views/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splash',
      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => HomePage(),
      'splash':(context) => Splash()
      },
    );
  }
}
