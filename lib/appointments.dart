import 'package:flutter/material.dart';

class MakeAppointmentPage extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr.D. Senanayaka',
      'specialty': 'Pediatrician',
      'rating': 5.0,
      'reviews': 1872,
      'image': 'assets/doctor1.png', // Replace with your asset paths
    },
    {
      'name': 'Dr. H. Uduwage',
      'specialty': 'Pediatrician',
      'rating': 4.9,
      'reviews': 1652,
      'image': 'assets/doctor2.png', // Replace with your asset paths
    },
    {
      'name': 'Dr.D. Bandara',
      'specialty': 'VOG',
      'rating': 4.7,
      'reviews': 1169,
      'image': 'assets/doctor3.png', // Replace with your asset paths
    },
    {
      'name': 'Dr.D. Senanayaka',
      'specialty': 'Pediatrician',
      'rating': 5.0,
      'reviews': 1872,
      'image': 'assets/doctor1.png', // Replace with your asset paths
    },
    {
      'name': 'Dr. H. Uduwage',
      'specialty': 'Pediatrician',
      'rating': 4.9,
      'reviews': 1652,
      'image': 'assets/doctor2.png', // Replace with your asset paths
    },
    {
      'name': 'Dr.D. Bandara',
      'specialty': 'VOG',
      'rating': 4.7,
      'reviews': 1169,
      'image': 'assets/doctor3.png', // Replace with your asset paths
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Make your Appointment",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF52C6A9),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Container(
            color: Color(0xFF52C6A9),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all((10)),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF52C6A9),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                        ),
                        child: Column(children: [
                          SizedBox(height: 30,),
                         Container(
                           margin: EdgeInsets.symmetric(horizontal: 10),
                           child: TextField(
                             decoration: InputDecoration(

                               prefixIcon: Icon(Icons.search),
                               hintText: 'search a doctor..',
                               filled: true,
                               fillColor: Colors.white,
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(25),
                                 borderSide: BorderSide.none,
                               ),
                             ),
                           ),
                         ),
                          SizedBox(height: 20),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: doctors.length,
                                  itemBuilder: (context, index) {
                                    return DoctorCard(
                                      name: doctors[index]['name'],
                                      specialty: doctors[index]['specialty'],
                                      rating: doctors[index]['rating'],
                                      reviews: doctors[index]['reviews'],
                                      imagePath: doctors[index]['image'],
                                    );
                                  }))
                        ]),
                      ),
                    ),

                  ],
                ),
              ),
            )));
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String imagePath;

  const DoctorCard({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    specialty,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 5),
                      Text(
                        '$reviews Reviews',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Icon(Icons.favorite_border, color: Colors.grey),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Learn more',
                    style: TextStyle(fontSize: 12, color: Colors.teal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
