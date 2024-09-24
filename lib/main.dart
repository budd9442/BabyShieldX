import 'package:babyshieldx/base.dart';
import 'package:babyshieldx/coverpage.dart';
import 'package:babyshieldx/hospital_register.dart';
import 'package:babyshieldx/models/child_provider.dart';
import 'package:babyshieldx/parent_register.dart';
import 'package:babyshieldx/sign_in.dart';
import 'package:babyshieldx/sign_up_as.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepage.dart'; // Import your homepage

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChildrenProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  CoverPage(),
      routes: {
        '/signup': (context) => SignUpMenu(),
        '/login': (context) => SignInPage(),
        '/hospital_signup': (context) => HospitalSignUp(),
        '/parent_signup': (context) => ParentRegisterScreen(),
        '/hospital_signup': (context) => HospitalSignUpScreen(),
        '/home' : (context) => TabBase(),

      },
    );
  }
}