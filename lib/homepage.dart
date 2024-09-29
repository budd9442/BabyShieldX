import 'package:babyshieldx/add_child.dart';
import 'package:babyshieldx/appointments.dart';
import 'package:babyshieldx/base.dart';
import 'package:babyshieldx/calendar.dart';
import 'package:babyshieldx/models/child_provider.dart';
import 'package:babyshieldx/models/models.dart';
import 'package:babyshieldx/schedule.dart';
import 'package:babyshieldx/vaccine_centers.dart';
import 'package:babyshieldx/vaccine_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final Function(int) changeTab; // Accept the function to switch tabs

  HomePage({required this.changeTab});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String> nextVaccinationInfo = ['', '', '', '']; // Array to store vaccination info

  @override
  void initState() {
    super.initState();
    _fetchNextVaccination();
    print(nextVaccinationInfo);
  }

  Future<void> _fetchNextVaccination() async {
    try {
      final supabase = Supabase.instance.client;
      final vaccinationData = await supabase.from('vaccination_types').select();
      final childrenProvider = Provider.of<ChildrenProvider>(context, listen: false);
      List<Child> children = childrenProvider.children;

      List<Event> upcomingVaccinations = [];

      for (var child in children) {
        for (var vaccine in vaccinationData) {
          DateTime nextVaccinationDate = _calculateNextVaccinationDate(child.dateOfBirth, vaccine['months'], vaccine['years']);

          if (nextVaccinationDate.isAfter(DateTime.now())) {
            upcomingVaccinations.add(Event(
              title: "${child.name}'s ${vaccine['name']}",
              dateTime: nextVaccinationDate,
              profileImage: child.profileImage,
              color: child.gender == 'Female'
                  ? Colors.pinkAccent.shade100
                  : Colors.lightBlueAccent.shade100,
              babyName: child.name,
              vaccineType: vaccine['name'],
            ));
          }
        }
      }

      upcomingVaccinations.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Sort by date

      if (upcomingVaccinations.isNotEmpty) {
        final nextVaccination = upcomingVaccinations.first;

        setState(() {
          nextVaccinationInfo[0] = nextVaccination.babyName; // Child's name
          nextVaccinationInfo[1] = nextVaccination.vaccineType; // Vaccine name
          nextVaccinationInfo[2] = DateFormat.d().format(nextVaccination.dateTime); // Vaccine date
          nextVaccinationInfo[3] = DateFormat.MMMM().format(nextVaccination.dateTime); // Vaccine month
        });
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  DateTime _calculateNextVaccinationDate(DateTime birthDate, int months, int years) {
    return DateTime(birthDate.year + years, birthDate.month + months, birthDate.day);
  }

  String _getDateSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }






  Future<void> _handleSignOut() async {
    // Sign out the user
    await Supabase.instance.client.auth.signOut();
    Navigator.pushReplacementNamed(context, '/login'); // Redirect to login page
  }

  @override
  Widget build(BuildContext context) {
    final childrenProvider = Provider.of<ChildrenProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF52C6A9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: AppBar(
            iconTheme: const IconThemeData(size: 44),
            backgroundColor: const Color(0xFF52C6A9),
            title: Text(
              'Hello,\n${Supabase.instance.client.auth.currentUser!.userMetadata?["parent_name"]}',
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.w900),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: CircleAvatar(
                  minRadius: 30,
                  backgroundImage: AssetImage(
                      'assets/profile.png'), // Change this path accordingly
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.teal,
              ),
              child: Stack(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BabyShieldX",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      Text(
                        "Let's Get \nVaccinated!",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/doctor_child.png', height: 100)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Home navigation
            ListTile(
              tileColor: Colors.teal.shade200,
              leading: const Icon(Icons.home, size: 32),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                widget.changeTab(0); // Switch to Home tab
                Navigator.pop(context); // Close the drawer
              },
            ),
            const SizedBox(height: 10),
            // Child List navigation
            ListTile(
              tileColor: Colors.teal.shade200,
              leading: const Icon(Icons.child_friendly, size: 32),
              title: const Text(
                'Child List',
                style: TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                widget.changeTab(2); // Switch to Manage Children tab
                Navigator.pop(context); // Close the drawer
              },
            ),
            const SizedBox(height: 10),
            // Calendar navigation
            ListTile(
              tileColor: Colors.teal.shade200,
              leading: const Icon(Icons.calendar_month, size: 32),
              title: const Text(
                'Calendar',
                style: TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                widget.changeTab(1); // Switch to Calendar tab
                Navigator.pop(context); // Close the drawer
              },
            ),
            const SizedBox(height: 10),
            // Doctor Channeling
            ListTile(
              tileColor: Colors.teal.shade200,
              leading: const Icon(Icons.health_and_safety, size: 32),
              title: const Text(
                'Doctor Channeling',
                style: TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MakeAppointmentPage()
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            // Vaccine Centers navigation
            ListTile(
              tileColor: Colors.teal.shade200,
              leading: const Icon(Icons.location_on, size: 32),
              title: const Text(
                'Vaccine Centers',
                style: TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VaccineCenterPage(imagePath: ''), // Pass the child to ChildDashboard
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            // Settings
            ListTile(
              tileColor: Colors.teal.shade200,
              leading: const Icon(Icons.settings, size: 32),
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                widget.changeTab(3); // Switch to Settings tab
                Navigator.pop(context); // Close the drawer
              },
            ),
            const SizedBox(height: 10),
            // About Us
            ListTile(
              tileColor: Colors.teal.shade200,
              leading: const Icon(Icons.emoji_people, size: 32),
              title: const Text(
                'About Us',
                style: TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                // Navigate to About Us
              },
            ),
            const SizedBox(height: 10),
            // Log Out
            ListTile(
              tileColor: Colors.teal.shade200,
              leading: const Icon(Icons.logout, size: 32),
              title: const Text(
                'Log Out',
                style: TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                _handleSignOut();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26), topRight: Radius.circular(26))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Upcoming vaccination section
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF52C6A9),
                            Color.lerp(Colors.white, const Color(0xFF52C6A9), 0.6)!
                          ],
                          end: Alignment.bottomLeft,
                          begin: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      'Upcoming vaccination:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/calendar_home.png',
                                  height: 120,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VaccineSchedulePage(
                                          children: childrenProvider.children, // Pass the child list
                                          initialIndex: 0, // Set the initial index if required
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('View schedule'),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(

                                    height: 30,
                                      ),
                                      Text(
                                           "3ʳᵈ" ,
                                        style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "April",
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Cheyana\nMMR Vaccine',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Quick response card
                    SizedBox(height: 10,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  const Text(
                                    textAlign: TextAlign.center,
                                    'You can explore our full medical services through our official website. This app is helpful for getting an appointment with your doctor.',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Quick response action
                                      },
                                      child: const Text('Quick response'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/doctor.png',
                              height: 110,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Bottom buttons

                    Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VaccinePage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.search, color: Colors.white),
                              label: const Text(
                                "Vaccination Details",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF52C6A9),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          FloatingActionButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddChildScreen()), // Open AddChildScreen
                            ),
                            child: const Icon(Icons.add_outlined),
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
