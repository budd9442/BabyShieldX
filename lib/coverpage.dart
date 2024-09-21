import 'package:flutter/material.dart';
class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(

          image: DecorationImage(
            image: AssetImage("assets/cover_bg.png"), // Add your background image
            fit: BoxFit.cover, // Make the image cover the entire screen
          ),
        ),child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Doctor and Child Image (Replace 'doctor_child.png' with the actual asset name)
            SizedBox(height: 120),
            Image.asset('assets/doctor_child.png', height: 300),

            SizedBox(height: 20),

            // Title Text
            const Text(
              "Let’s Get Vaccinated",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            // Get Started Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the sign-up menu
                Navigator.pushNamed(context, '/signup');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF61C5B1), backgroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),

              ),
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: 20),
              ),
            ),

            Spacer(),

            // App Name Footer
            Text(
              "BabyShieldX",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
