import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF52C6A9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: AppBar(
              iconTheme: const IconThemeData(size: 44),
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
              backgroundColor: Color(0xFF52C6A9),
              title: const Text(
                'Hello,\nSupun Dharmaratne',
                style: TextStyle(
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
            )),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              onTap: () {
                // Handle navigation
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      body: Container(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26), topRight: Radius.circular(26))),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(


                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF52C6A9), Color.lerp(Colors.white,Color(0xFF52C6A9), 0.6)!],
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
                                    'Upcoming vaccination :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/calendar_home.png',
                                // Change this path accordingly
                                height: 120,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to schedule
                                },
                                child: Text('View schedule'),
                              ),
                            ],
                          ),
                          const Flexible(
                              child: Column(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Column(children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  '03ʳᵈ',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'January',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Mary Jane\nDTP-Hib-HepB',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ]),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
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
                                SizedBox(height: 8),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Quick response action
                                    },
                                    child: Text('Quick response'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/doctor.png', // Change this path accordingly
                            height: 110,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Define the action you want to perform on button press
                          },
                          icon: Icon(Icons.search, color: Colors.white),
                          // Search icon
                          label: const Text(
                            "Vaccination Details",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18), // Text color
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF52C6A9),
                            // Custom button color
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          // Add vaccination record
                        },
                        child: Icon(Icons.add_outlined),
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
