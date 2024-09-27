import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models.dart'; // Adjust this import as needed

class ChildrenProvider with ChangeNotifier {
  List<Child> _children = [];

  List<Child> get children => _children;

  Future<void> fetchChildren() async {
    try {
      final data = await Supabase.instance.client.from('children').select();
      if (data.isNotEmpty) {
        _children.clear();
        for (var child in data) {
          _children.add(Child(
              name: child['name'],

              profileImage: child['avatar'],
              gender: child['gender'],
              dateOfBirth: DateTime.parse(child['date_of_birth']),
              height: child['height']+0.0,
              weight: child['weight']+0.0,
              pastVaccinations: [],
              nextVaccinationDate: DateTime(2025),
              vaccines: [])
          );
        }
      }
      notifyListeners(); // Notify listeners about the state change
    } catch (e) {
      print('An exceptionnnn occurred: $e');
    }
  }

  void addChild(Child child) {
    _children.add(child);
    notifyListeners();
  }

  void removeChild(Child child) {
    _children.remove(child);
    notifyListeners();
  }

// You can add more methods to modify the children list as needed
}
