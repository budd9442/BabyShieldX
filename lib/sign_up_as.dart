import 'package:flutter/material.dart';

class SignUpMenu extends StatelessWidget {
  const SignUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(

          image: DecorationImage(
            image: AssetImage('assets/cover_bg.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BabySheildX",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 50),

            // Sign Up as Hospital
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/hospital_signup');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.yellow[100], // Background color for card
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_hospital, size: 50),
                    SizedBox(width: 20),
                    Text(
                      "Sign Up as a Hospital",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Sign Up as Parent
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/parent_signup');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.family_restroom, size: 50),
                    SizedBox(width: 20),
                    Text(
                      "Sign Up as a Parent",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 100),

            // Already have an account?
            Text("Already have an Account?", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colors.black)),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Placeholder for Hospital Sign Up Page
class HospitalSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hospital Sign Up")),
      body: Center(child: Text("Hospital Sign Up Page")),
    );
  }
}

// Placeholder for Parent Sign Up Page
class ParentSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parent Sign Up")),
      body: Center(child: Text("Parent Sign Up Page")),
    );
  }
}
