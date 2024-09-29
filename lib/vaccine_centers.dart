import 'package:flutter/material.dart';

class VaccineCenterPage extends StatelessWidget {
  final String imagePath;

  const VaccineCenterPage({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full screen local image
          Positioned.fill(
            child: Image.asset(
              "assets/vaccineCenters.png",
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          // Back button
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop(); // Navigate back
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}