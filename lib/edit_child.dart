import 'package:babyshieldx/models/models.dart';
import 'package:flutter/material.dart';

class EditChildScreen extends StatefulWidget {
  final Child child;

  EditChildScreen({required this.child});

  @override
  _EditChildScreenState createState() => _EditChildScreenState();
}

class _EditChildScreenState extends State<EditChildScreen> {
  late String _selectedAvatar;
  late String _name;
  late DateTime _dateOfBirth;
  late double _height;
  late double _weight;
  late Color _selectedColor;

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

  final List<Color> _pastelColors = [
    Colors.pinkAccent.shade100,
    Colors.lightBlueAccent.shade100,
    Colors.greenAccent.shade100,
    Colors.yellowAccent.shade100,
    Colors.orangeAccent.shade100,
    Colors.purpleAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.blueGrey.shade100,
    Colors.cyanAccent.shade100,
    Colors.amberAccent.shade100,
    Colors.limeAccent.shade100,
    Colors.redAccent.shade100,
  ];

  @override
  void initState() {
    super.initState();
    _selectedAvatar = widget.child.profileImage;
    _name = widget.child.name;
    _dateOfBirth = widget.child.dateOfBirth;
    _height = widget.child.height;
    _weight = widget.child.weight;

  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth)
      setState(() {
        _dateOfBirth = picked;
      });
  }

  void _openAvatarSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Text("Select an avatar",style: TextStyle(fontSize: 20),),
            SizedBox(height: 30,),
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
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF52C6A9),
        title: Text("Edit Child Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar selection
            Center(
              child: GestureDetector(
                onTap: _openAvatarSelection,
                child: CircleAvatar(
                  backgroundImage: AssetImage(_selectedAvatar),
                  radius: 80,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: "Name"),
              onChanged: (value) => setState(() {
                _name = value;
              }),
            ),

            SizedBox(height: 20),
            TextFormField(
              initialValue: _height.toString(),
              decoration: InputDecoration(labelText: "Height (cm)"),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                _height = double.tryParse(value) ?? _height;
              }),
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: _weight.toString(),
              decoration: InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                _weight = double.tryParse(value) ?? _weight;
              }),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                  "Date of Birth: ${_dateOfBirth.toLocal().toString().split(' ')[0]}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 20),
            Text("Select a Color"),
            SizedBox(height: 10),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _pastelColors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = _pastelColors[index];
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: _pastelColors[index],
                        shape: BoxShape.circle,
                        border: _selectedColor == _pastelColors[index]
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Save changes to the child profile
                setState(() {
                  widget.child.name = _name;
                  widget.child.dateOfBirth = _dateOfBirth;
                  widget.child.height = _height;
                  widget.child.weight = _weight;
                  widget.child.profileImage = _selectedAvatar;
                });
                Navigator.pop(context, widget.child); // Return the updated child object

              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
