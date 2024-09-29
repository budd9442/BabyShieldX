import 'package:flutter/material.dart';

class FullScreenPhotoPage extends StatelessWidget {
  final String imagePath;

  const FullScreenPhotoPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF52C6A9),
      appBar: AppBar(
        backgroundColor: Color(0xFF52C6A9),
        title: Text("Growth Details", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/weightChart.png",
            fit: BoxFit.contain, // Ensures the image covers the entire screen
          ),
          Expanded(child: Container(
            color: Colors.white,
          ))
        ],
      )
    );
  }
}
