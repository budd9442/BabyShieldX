import 'package:flutter/material.dart';

class Vaccination {
   String name;
   DateTime date;
   bool isCompleted;

  Vaccination({
    required this.name,
    required this.date,
    this.isCompleted = false,
  });
}

class Child {
  String name;
   int age; // Age in months
   String profileImage;
   String gender; // e.g., "baby boy" or "baby girl"
   DateTime dateOfBirth;
   double height; // height in cm
   double weight; // weight in kg
   Color color;
   List<Vaccination> pastVaccinations;
   DateTime nextVaccinationDate;
  int vaccinationCount;
  double vaccinationProgress;

  Child({
    required this.name,
    required this.age,
    required this.profileImage,
    required this.gender,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.color,
    required this.pastVaccinations,
    required this.nextVaccinationDate,
  })  : vaccinationCount = pastVaccinations.where((v) => v.isCompleted).length,
        vaccinationProgress = _calculateVaccinationProgress(pastVaccinations);

  static double _calculateVaccinationProgress(List<Vaccination> vaccinations) {
    if (vaccinations.isEmpty) return 0.0;
    int completedCount = vaccinations.where((v) => v.isCompleted).length;
    return (completedCount / vaccinations.length) * 100;
  }
}
