// Import the ChildDashboard screen
import 'package:babyshieldx/child_dashboard.dart'; // Assuming you've saved the ChildDashboard as 'child_dashboard.dart'.

import 'package:babyshieldx/models/models.dart';
import 'package:flutter/material.dart';

class ManageChildrenPage extends StatefulWidget {
  @override
  _ManageChildrenPageState createState() => _ManageChildrenPageState();
}

class _ManageChildrenPageState extends State<ManageChildrenPage> {
  final List<Child> _children = [];

  @override
  void initState() {
    super.initState();
    // Sample data
    _children.addAll([
      Child(
        name: 'Alice Johnson',
        age: 3,
        nextVaccinationDate: DateTime.now().add(Duration(days: 30)),
        profileImage: 'assets/avatars/avatar1.png',
        dateOfBirth: DateTime(2003),
        height: 180,
        weight: 80,
        color: Colors.lightBlueAccent,
        pastVaccinations: [], gender: 'Female',
      ),
      Child(
        name: 'John Smith',
        age: 5,
        nextVaccinationDate: DateTime.now().add(Duration(days: 60)),
        profileImage: 'assets/avatars/avatar2.png',
        dateOfBirth: DateTime(2010),
        height: 150,
        weight: 50,
        color: Colors.lightGreenAccent,
        pastVaccinations: [], gender: 'Male',
      ),
    ]);
  }

  void _viewChildProfile(Child child) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChildDashboard(child: child), // Pass the child to ChildDashboard
      ),
    );
  }

  Widget _buildChildCard(Child child) {
    return Container(
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [child.color, child.color.withOpacity(child.color.opacity/2)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,

          ),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.fromLTRB(10, 10 , 10, 0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // Profile Image with rounded rectangle shape
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                child: Image.asset(
                  child.profileImage,
                  width: 150, // Fixed width for responsiveness
                  height: 150, // Fixed height for responsiveness
                  fit: BoxFit.cover, // Maintain aspect ratio
                ),
              ),
              SizedBox(width: 10),

              Expanded(
                child: Column(children: [
                  Text(
                    child.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1, // Limit to a single line
                  ),
                  Text(
                    "Age: ${child.age} years",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text(
                    "Next Vaccination ",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text(
                    "${child.nextVaccinationDate.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () => _viewChildProfile(child),
                    child: Text("View Profile"),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addOrEditChildPopup([Child? child]) {
    // Add logic to show a popup for adding or editing a child
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF52C6A9),
      appBar: AppBar(
        title: Text("Manage Children"),
        backgroundColor: Color(0xFF52C6A9),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26))),
        child:  ListView(
          children: _children.map((child) => _buildChildCard(child)).toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditChildPopup(),
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF52C6A9),
      ),
    );
  }
}
