import 'package:babyshieldx/base.dart';
import 'package:babyshieldx/coverpage.dart';
import 'package:babyshieldx/hospital_register.dart';
import 'package:babyshieldx/models/child_provider.dart';
import 'package:babyshieldx/parent_register.dart';
import 'package:babyshieldx/sign_in.dart';
import 'package:babyshieldx/sign_up_as.dart';
import 'package:babyshieldx/vaccine_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'homepage.dart'; // Import your homepage

void main() async {
  await Supabase.initialize(
    url: 'https://nojvtxhgmzngvybwkmao.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5vanZ0eGhnbXpuZ3Z5YndrbWFvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU3MDkwMzUsImV4cCI6MjA0MTI4NTAzNX0.ackuVyEATlKbA-CxutGu6ECiRkyKS9xwtxydcG2hJug',
  );
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
        '/base' : (context) => TabBase(),
        '/vaccines' : (context) => VaccinePage(),

      },
    );
  }
}