import 'package:babyshieldx/models/child_provider.dart';
import 'package:babyshieldx/schedule.dart';
import 'package:babyshieldx/weightChart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Import the mobile scanner package
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/models.dart'; // Assuming models.dart contains the Child class

class ChildDashboard extends StatelessWidget {
  final Child child;
  final int vaccinesTaken;

  ChildDashboard({
    required this.child,
    required this.vaccinesTaken,
  });

  @override
  Widget build(BuildContext context) {
    final childrenProvider = Provider.of<ChildrenProvider>(context);
    print(vaccinesTaken);

    int count = 0;

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
                  color: child.gender == 'Female'
                      ? Colors.pinkAccent.withAlpha(180)
                      : Colors.blueAccent.withAlpha(180),
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
                                getAge(child.dateOfBirth) + " old",
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
                        IconButton(
                          icon: Icon(Icons.qr_code_scanner_rounded,
                              color: Colors.black54, size: 56),
                          onPressed: () {
                            // _scanQRCode(context); // Call the QR code scanner
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    QRCodeOverlay(childName: child.name),
                              ),
                            );
                          },
                        ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VaccineSchedulePage(
                                children: childrenProvider.children,
                                // Pass the relevant child or children
                                initialIndex:
                                    0, // If needed, you can set an initial index
                              ),
                            ),
                          );
                        }),
                    _buildDashboardOption(
                        icon: Icons.bar_chart,
                        title: "Growth Details",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenPhotoPage(imagePath: 'assets/weightChart.png',), // Pass the child to ChildDashboard
                            ),
                          );
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
                              "${vaccinesTaken} doses vaccinated",
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(
                              "${(vaccinesTaken / 12 * 100).toStringAsFixed(0)}% completed",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: vaccinesTaken / 12,
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
          ),
        )
      ],
    );
  }

  // Function to open the QR Code scanner
  // Function to open the QR Code scanner and push the data to Supabase

  void _showQRCodeOverlay(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeOverlay(childName: child.name),
      ),
    );
  }

  // void _scanQRCode(BuildContext context) async {
  //   final String? scannedCode = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => QRCodeScanner(),
  //     ),
  //   );
  //
  //   if (scannedCode != null) {
  //     // Push data to Supabase
  //     await _saveVaccinationToSupabase(scannedCode, child.name);
  //
  //     // Show a confirmation dialog
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('Scanned QR Code'),
  //         content: Text('Vaccination for ${child.name} saved: $scannedCode'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
  //
  // // Function to save the scanned QR code and child's name to Supabase
  // Future<void> _saveVaccinationToSupabase(String qrCode, String childName) async {
  //   final supabase = Supabase.instance.client;
  //
  //   // Assuming the 'vaccinations' table has columns: vac_id, child, and date
  //   final response = await supabase.from('vaccinations').insert({
  //     'vac_id': qrCode,  // QR Code scanned
  //     'child': childName, // Child's name
  //     'vac_date': DateTime.now().toIso8601String(), // Current date
  //   });
  //
  //   if (response.error != null) {
  //     // Handle error
  //     print('Error saving vaccination: ${response.error!.message}');
  //   } else {
  //     print('Vaccination saved successfully');
  //   }
  // }

  Widget _buildDashboardOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    Color accentColor = child.gender == 'Female'
        ? Colors.pinkAccent.withAlpha(180)
        : Colors.blueAccent.withAlpha(180);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(Colors.white, accentColor, 0.6)!,
                accentColor
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
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
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

// QR Code Scanner Page
class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Please scan he QR Code"),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            if (code != null) {
              Navigator.pop(context, code); // Return the scanned code
            }
          }
        },
      ),
    );
  }
}

class QRCodeOverlay extends StatelessWidget {
  final String childName;

  QRCodeOverlay({required this.childName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code for $childName"),
      ),
      backgroundColor: Color(0xFF52C6A9), // Match background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Upper QR Code section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF52C6A9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: QrImageView(
                  data: childName,
                  version: QrVersions.auto,
                  size: 250.0,
                ),
              ),
            ),
          ),

          // Lower rounded section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.teal, // Matching the spinner color
                ),
                SizedBox(height: 20),
                Text(
                  "Waiting for Doctor update",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Please ask your doctor to scan this in order to update your vaccination records",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
