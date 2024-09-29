import 'package:babyshieldx/models/child_provider.dart';
import 'package:babyshieldx/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddChildScreen extends StatefulWidget {
  @override
  _AddChildScreenState createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  String _selectedAvatar = 'assets/avatars/avatar1.png'; // Default avatar
  String _name = '';
  DateTime _dateOfBirth = DateTime.now();
  double _weight = 0.0;
  double _height = 0.0;
  String _gender = 'Female';
  final List<String> _genders = ['Female', 'Male', 'Other'];

  final List<String> _avatars = [
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
    'assets/avatars/avatar6.png',
    'assets/avatars/avatar7.png',
    'assets/avatars/avatar8.png',
    'assets/avatars/avatar9.png',
    'assets/avatars/avatar10.png',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  void _scanQrCode() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Scan QR code"),
          content: Text('Not Implemented yet'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openAvatarSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Text("Select an avatar", style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            Container(
              height: 300,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _avatars.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = _avatars[index];
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _avatars[index] == _selectedAvatar
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        _avatars[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final childrenProvider = Provider.of<ChildrenProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF52C6A9),
          title: Text("Add Child Details"),
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
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF52C6A9),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: _openAvatarSelection,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            // Align the edit icon to the bottom right corner
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(_selectedAvatar),
                                radius: 100,
                                backgroundColor: Colors.transparent,
                              ),
                              GestureDetector(
                                onTap: _openAvatarSelection,
                                // Call the function to open avatar selection
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF52C6A9),
                                    // Background color for the icon
                                    shape: BoxShape.circle,
                                    // Make it circular
                                  ),
                                  child: Icon(
                                    Icons.add_circle_outlined, // Edit icon
                                    color: Colors.white, // Icon color
                                    size: 40, // Icon size
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Child's Name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) => setState(() {
                                    _name = value;
                                  }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                DropdownButtonFormField<String>(
                                  dropdownColor: Colors.teal.shade500,
                                  value: _gender,
                                  items: _genders
                                      .map((gender) => DropdownMenuItem(
                                            value: gender,
                                            child: Text(gender,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value ?? 'Female';
                                    });
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Child's Height",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Ex: 100 cm",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => setState(() {
                                    _height = double.tryParse(value) ?? _height;
                                  }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Child's Weight",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Ex: 2.5 kg",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => setState(() {
                                    _weight = double.tryParse(value) ?? _weight;
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Date of Birth",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            width: MediaQuery.of(context).size.width / 2 - 35,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _dateOfBirth
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.calendar_today, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 35,
                        // Makes the button take the full width of the container
                        child: ElevatedButton(
                          onPressed: () async {

                            // Create the new child object
                            final newChild = Child(
                              height: _height,
                              name: _name,
                              dateOfBirth: _dateOfBirth,
                              weight: _weight,
                              profileImage: _selectedAvatar,
//                              age: DateTime.now().year - _dateOfBirth.year,
                              nextVaccinationDate:
                                  DateTime.now().add(Duration(days: 30)),
                              pastVaccinations: [],
                              gender: _gender,
                              vaccines: [],
                            );

                            // Insert child data into Supabase

                            try {
                              //Insert child data into Supabase
                              final response = await Supabase.instance.client
                                  .from(
                                      'children') // Name of the Supabase table
                                  .insert({
                                'name': newChild.name,
                                'date_of_birth':
                                    newChild.dateOfBirth.toIso8601String(),
                                // ISO format for DateTime
                                'weight': newChild.weight,
                                'height': newChild.height,
                                'avatar': newChild.profileImage,
                                'gender': newChild.gender,
                                //'next_vaccination_date': newChild.nextVaccinationDate.toIso8601String(), // Assuming this field exists
                              });

                            } catch (e) {
                              // Handle any exceptions that may occur
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('An yerror occurred: $e')),
                              );
                            } finally {
                              await childrenProvider.fetchChildren();
                              print(childrenProvider.children.length);// Refresh the provider data
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            " Save ",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            // Set the background color to white
                            side: BorderSide(color: Colors.teal, width: 2),
                            // Add teal border
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15), // Optional: set border radius
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: Image.asset(
                            'assets/child_with_parent.png',
                            // Make sure this path matches your asset location
                            height: 220,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
