import 'package:babyshieldx/add_child.dart';
import 'package:babyshieldx/child_dashboard.dart';
import 'package:babyshieldx/models/child_provider.dart';
import 'package:babyshieldx/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ManageChildrenPage extends StatefulWidget {
  @override
  _ManageChildrenPageState createState() => _ManageChildrenPageState();
}

class _ManageChildrenPageState extends State<ManageChildrenPage> {
  bool isLoading = true; // New loading state variable

  @override
  void initState() {
    super.initState();
    _fetchChildren(); // Fetch children data on initialization
  }

  Future<void> _fetchChildren() async {
    final childrenProvider = Provider.of<ChildrenProvider>(context, listen: false);
    await childrenProvider.fetchChildren();
    setState(() {
      isLoading = false; // Set loading to false after fetching data
    });
  }

  String getAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    final difference = now.difference(dateOfBirth);

    final years = difference.inDays ~/ 365;
    final months = difference.inDays ~/ 30;
    final days = difference.inDays;

    if (days < 30) {
      return "$days days";
    } else if (months < 12) {
      return "$months months";
    } else {
      return "$years years";
    }
  }


  void _viewChildProfile(Child child) {
    int vaccinesTaken = 0;

    final response = Supabase.instance.client
        .from('vaccinations')
        .select('*') // Request the count
        .eq('child', child.name).count(CountOption.exact);

    response.then((response) {
      final data = response.data; // The list of vaccinations
      vaccinesTaken = data.length;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChildDashboard(child: child,vaccinesTaken: vaccinesTaken,), // Pass the child to ChildDashboard
        ),
      );
      // Do something with data and count
    }).catchError((error) {
      // Handle any errors
    });

  }

  Widget _buildChildCard(Child child) {
    Color accentColor = child.gender == 'Female'
        ? Colors.pinkAccent.withAlpha(100)
        : Colors.lightBlueAccent.withAlpha(100);
    return Container(
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accentColor, accentColor.withOpacity(accentColor.opacity / 2)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                    "Age: ${getAge(child.dateOfBirth)} ",
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
    final childrenProvider = Provider.of<ChildrenProvider>(context);

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
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        child: isLoading // Show loading indicator if loading
            ? Center(child: CircularProgressIndicator())
            : Consumer<ChildrenProvider>(
          builder: (context, childrenProvider, child) {
            return ListView(
              children: childrenProvider.children.map((child) => _buildChildCard(child)).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddChildScreen()), // Open AddChildScreen
        ),
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF52C6A9),
      ),
    );
  }
}
