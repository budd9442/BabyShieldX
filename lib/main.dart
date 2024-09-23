import 'package:babyshieldx/base.dart';
import 'package:babyshieldx/coverpage.dart';
import 'package:babyshieldx/sign_in.dart';
import 'package:babyshieldx/sign_up_as.dart';
import 'package:flutter/material.dart';
import 'homepage.dart'; // Import your homepage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabBase(),
      routes: {
        '/signup': (context) => SignUpMenu(),
        '/login': (context) => SignInPage(),
        '/hospital_signup': (context) => HospitalSignUp(),
        '/parent_signup': (context) => ParentSignUp(),
        '/home' : (context) => const HomePage(),
      },
    );
  }
}