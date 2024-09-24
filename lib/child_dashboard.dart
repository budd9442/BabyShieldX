import 'package:flutter/material.dart';
import 'models/models.dart'; // Assuming models.dart contains the Child class

class ChildDashboard extends StatelessWidget {
  final Child child;

  ChildDashboard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                // Child Profile Card
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: child.color,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Child Image
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(child.profileImage),
                        ),
                        SizedBox(width: 16),
                        // Child Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                child.name,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${child.age} months old",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Date of Birth: ${child.dateOfBirth.toLocal().toString().split(' ')[0]}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.qr_code, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 6),
                // Upcoming Vaccinations
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upcoming",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Text(
                          "DTP–HepB–Hib III",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "January 3, 2024",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "MMR – (Measles, Mumps, Rubella)",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "April 5, 2024",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 6),
                // Options Grid
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildDashboardOption(
                        icon: Icons.schedule,
                        title: "View Schedule",
                        onTap: () {
                          // Handle View Schedule tap
                        }),
                    _buildDashboardOption(
                        icon: Icons.bar_chart,
                        title: "Growth Details",
                        onTap: () {
                          // Handle Growth Details tap
                        }),
                    _buildDashboardOption(
                        icon: Icons.vaccines,
                        title: "Vaccine Request",
                        onTap: () {
                          // Handle Vaccine Request tap
                        }),
                    _buildDashboardOption(
                        icon: Icons.receipt_long,
                        title: "Get My Report",
                        onTap: () {
                          // Handle Get My Report tap
                        }),
                  ],
                ),
                SizedBox(height: 6),
                // Vaccination Progress Bar
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vaccination Progress",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${child.vaccinationCount} doses vaccinated",
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(
                              "${child.vaccinationProgress}% completed",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: child.vaccinationProgress / 100,
                          backgroundColor: Colors.grey.shade300,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),

                ),
              ],
            ))
      ],
    );
  }

  Widget _buildDashboardOption(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(Colors.white, child.color, 0.6)!,
                child.color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
