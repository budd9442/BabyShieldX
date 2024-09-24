import 'package:flutter/material.dart';
import 'models.dart'; // Adjust this import as needed


class ChildrenProvider with ChangeNotifier {


  final List<Child> _children = [
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
        vaccines: [
          Vaccine(name: "DTP-HepB-Hib I", dueInMonths: 2, status: VaccineStatus.completed),
          Vaccine(name: "BCG", dueInMonths: 2, status: VaccineStatus.completed),
          Vaccine(name: "Oral Polio Vaccine I - OPV", dueInMonths: 2, status: VaccineStatus.completed),
          Vaccine(name: "Fractional IPV II", dueInMonths: 4, status: VaccineStatus.delayed, delayedBy: Duration(days: 60)),
          Vaccine(name: "DTP-HepB-Hib III", dueInMonths: 6, status: VaccineStatus.upcoming),
          Vaccine(name: "MMR - (Measles, Mumps, Rubella)", dueInMonths: 9, status: VaccineStatus.upcoming),
        ],
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
        vaccines: [
          Vaccine(name: "DTP-HepB-Hib I", dueInMonths: 2, status: VaccineStatus.delayed),
          Vaccine(name: "BCG", dueInMonths: 2, status: VaccineStatus.completed),
          Vaccine(name: "Oral Polio Vaccine I - OPV", dueInMonths: 2, status: VaccineStatus.completed),
          Vaccine(name: "Fractional IPV II", dueInMonths: 4, status: VaccineStatus.delayed, delayedBy: Duration(days: 60)),
          Vaccine(name: "DTP-HepB-Hib III", dueInMonths: 6, status: VaccineStatus.upcoming),
          Vaccine(name: "MMR - (Measles, Mumps, Rubella)", dueInMonths: 9, status: VaccineStatus.upcoming),
        ]
    ),
  ];



  List<Child> get children => _children;

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
