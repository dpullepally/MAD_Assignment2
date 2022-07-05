import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_line/screens/bio_screen.dart';
import 'package:flutter_stream_line/screens/home_screen.dart';
import 'package:flutter_stream_line/screens/posts_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_stream_line/screens/login_screen.dart';
import 'package:flutter_stream_line/screens/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 10),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LoginScreen()
            )
        )
    );

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.orangeAccent,
            child: Padding(
              padding: const EdgeInsets.all(36.0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                       Image.asset(
                          "assets/images/logoremovebg.png",
                          fit: BoxFit.fill,
                        )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

}
