import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './screens/login_screen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      backgroundColor: Colors.white,
      image: Image.asset(
        'assets/takeoff.gif',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
      loadingText: new Text(
        'TripJot',
        style: TextStyle(
          fontSize: 70.0,
          color: Colors.amber,
          fontWeight: FontWeight.bold,
        ),
      ),
      useLoader: false,
      photoSize: 200.0,
      navigateAfterSeconds: LoginPage(),
    );
  }
}
