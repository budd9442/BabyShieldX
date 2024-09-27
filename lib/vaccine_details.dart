import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Vaccine {
  final String name;
  final String ageGiven;
  final String details;

  Vaccine({required this.name, required this.ageGiven, required this.details});

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(
      name: json['name'],
      ageGiven: json['age_given'],
      details: json['details'],
    );
  }
}

class VaccinePage extends StatefulWidget {
  @override
  _VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  final SupabaseClient client = Supabase.instance.client;
  List<Vaccine> vaccines = [];
  List<Vaccine> filteredVaccines = [];
  String searchQuery = '';
  bool isLoading = true; // New loading state variable

  @override
  void initState() {
    super.initState();
    fetchVaccines();
  }

  Future<void> fetchVaccines() async {
    try {
      final response = await client.from('vaccination_types').select();

        setState(() {
          vaccines = (response as List).map((item) {
            return Vaccine.fromJson(item);
          }).toList();
          filteredVaccines = vaccines;
          isLoading = false; // Set loading to false after fetching data
        });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Set loading to false in case of exception
      });
    }
  }

  void filterVaccines(String query) {
    setState(() {
      searchQuery = query;
      filteredVaccines = vaccines
          .where((vaccine) =>
          vaccine.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void showVaccineDetails(Vaccine vaccine) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(vaccine.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Age Given: ${vaccine.ageGiven}'),
                SizedBox(height: 8),
                Text('Details: ${vaccine.details}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> scanQRCode() async {
    // Implement the QR code scanner functionality
    // This function will need to handle QR code data and fetch corresponding vaccine info
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccine Information'),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: scanQRCode,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Vaccines...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: filterVaccines,
            ),
            SizedBox(height: 16),
            Expanded(
              child: isLoading // Show loading indicator if loading
                  ? Center(child: CircularProgressIndicator())
                  : filteredVaccines.isEmpty
                  ? Center(child: Text('No vaccines found'))
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredVaccines.length,
                itemBuilder: (context, index) {
                  final vaccine = filteredVaccines[index];
                  return GestureDetector(
                    onTap: () => showVaccineDetails(vaccine),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vaccine.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Age Given: ${vaccine.ageGiven}',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              vaccine.details,
                              maxLines: 2, // Limit text to 2 lines
                              overflow: TextOverflow.ellipsis, // Show ellipsis
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
