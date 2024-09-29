import 'package:flutter/material.dart';
import 'models/models.dart'; // Assuming models.dart contains the Child and Vaccine models
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart'; // Make sure to import this for date formatting

class VaccineSchedulePage extends StatefulWidget {
  final List<Child> children;
  final int initialIndex;

  VaccineSchedulePage({required this.children, this.initialIndex = 0});

  @override
  _VaccineSchedulePageState createState() => _VaccineSchedulePageState();
}

class _VaccineSchedulePageState extends State<VaccineSchedulePage> {
  late int _selectedChildIndex;
  late Child _currentChild;
  String _searchQuery = '';
  List<Vaccine> _vaccines = [];
  List<Vaccine> _upcomingVaccines = [];
  bool _isLoading = true; // To track loading state

  @override
  void initState() {
    super.initState();
    _selectedChildIndex = widget.initialIndex;
    _currentChild = widget.children[_selectedChildIndex];
    _fetchVaccinationData(); // Fetch vaccination data on init
  }

  void _switchChild(int index) {
    setState(() {
      _selectedChildIndex = index;
      _currentChild = widget.children[_selectedChildIndex];
      _searchQuery = ''; // Reset search query when switching children
      _vaccines.clear(); // Clear the vaccines list
      _upcomingVaccines.clear(); // Clear upcoming vaccines list
      _isLoading = true; // Set loading state
      _fetchVaccinationData(); // Fetch data for the selected child
    });
  }

  List<Vaccine> get _filteredVaccines {
    final allVaccines = [..._vaccines, ..._upcomingVaccines];
    if (_searchQuery.isEmpty) {
      return allVaccines;
    }
    return allVaccines
        .where((vaccine) =>
        vaccine.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  DateTime addMonthsAndYears(DateTime date, int monthsToAdd, int yearsToAdd) {
    int newYear = date.year + yearsToAdd;
    int newMonth = date.month + monthsToAdd;

    if (newMonth > 12) {
      newYear += (newMonth - 1) ~/ 12;
      newMonth = newMonth % 12;
    } else if (newMonth < 1) {
      newYear += (newMonth - 12) ~/ 12;
      newMonth = 12 + (newMonth % 12);
    }

    return DateTime(newYear, newMonth, date.day);
  }

  Future<void> _fetchVaccinationData() async {
    try {
      final data = await Supabase.instance.client
          .from('vaccination_types')
          .select();

      if (data != null && data.isNotEmpty) {
        List<Vaccine> vaccines = [];
        List<Vaccine> upcomingVaccines = [];

        for (var vaccineData in data) {
          String vaccineId = vaccineData['id'];
          String vaccineName = vaccineData['name'];
          int months = vaccineData['months'];
          int years = vaccineData['years'];
          DateTime nextVacDay = addMonthsAndYears(_currentChild.dateOfBirth, months, years);
          int daysDifference = nextVacDay.difference(DateTime.now()).inDays;

          if (daysDifference > 0) {
            upcomingVaccines.add(Vaccine(
              name: vaccineName,
              status: VaccineStatus.upcoming,
              dueInMonths: months + 12 * years,
              delayedBy: Duration.zero,
            ));
          } else {
            try {
              final vaccinationResponse = await Supabase.instance.client
                  .from('vaccinations')
                  .select()
                  .eq('vac_id', vaccineId)
                  .eq('child', _currentChild.name)
                  .single();

              DateTime vacDate = DateTime.parse(vaccinationResponse['vac_date']);
              int delayInDays = vacDate.difference(nextVacDay).inDays;

              VaccineStatus status = delayInDays > 7
                  ? VaccineStatus.delayed
                  : VaccineStatus.completed;

              vaccines.add(Vaccine(
                name: vaccineName,
                status: status,
                dueInMonths: months + 12 * years,
                delayedBy: Duration(days: delayInDays),
              ));
            } catch (e) {
              vaccines.add(Vaccine(
                name: vaccineName,
                status: VaccineStatus.missed,
                dueInMonths: months + 12 * years,
                delayedBy: Duration.zero,
              ));
            }
          }
        }

        // Combine vaccines and upcoming vaccines
        final allVaccines = [...vaccines, ...upcomingVaccines];

        // Sort by due date
        allVaccines.sort((a, b) {
          DateTime dueDateA = addMonthsAndYears(_currentChild.dateOfBirth, a.dueInMonths, 0);
          DateTime dueDateB = addMonthsAndYears(_currentChild.dateOfBirth, b.dueInMonths, 0);
          return dueDateA.compareTo(dueDateB); // Ascending order
        });

        // Separate them back to vaccines and upcomingVaccines
        _vaccines = allVaccines.where((vaccine) => vaccine.status != VaccineStatus.upcoming).toList();
        _upcomingVaccines = allVaccines.where((vaccine) => vaccine.status == VaccineStatus.upcoming).toList();

        setState(() {
          _isLoading = false; // Set loading state to false after data fetch
        });
      }
    } catch (e) {
      print('An error occurred while fetching vaccination data: $e');
      setState(() {
        _isLoading = false; // Set loading state to false even on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccine Schedule',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
        backgroundColor: Color(0xFF52C6A9),
      ),
      body: _isLoading // Show loading animation when fetching data
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Switch between children
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.children.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(widget.children[index].name),
                    selected: _selectedChildIndex == index,
                    onSelected: (selected) => _switchChild(index),
                  ),
                );
              }),
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Vaccines',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // Update the search query
                });
              },
            ),
          ),
          // Vaccine List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredVaccines.length,
              itemBuilder: (context, index) {
                final vaccine = _filteredVaccines[index];
                return _buildVaccineCard(vaccine);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaccineCard(Vaccine vaccine) {
    Color statusColor;
    String statusText;
    String subtitleText;

    DateTime nextDueDate = addMonthsAndYears(_currentChild.dateOfBirth, vaccine.dueInMonths, 0);

    switch (vaccine.status) {
      case VaccineStatus.completed:
        statusColor = Colors.green[100]!;
        int daysAgo = DateTime.now().difference(nextDueDate).inDays;
        statusText = '$daysAgo days ago';
        subtitleText = 'Completed on ${DateFormat('yyyy-MM-dd').format(nextDueDate)}'; // Format this date as needed
        break;
      case VaccineStatus.delayed:
        statusColor = Colors.red[100]!;
        statusText = 'Delayed by ${vaccine.delayedBy.inDays} days';
        subtitleText = 'Due on ${DateFormat('yyyy-MM-dd').format(nextDueDate)}'; // Format this date as needed
        break;
      case VaccineStatus.missed:
        statusColor = Colors.red[300]!;
        statusText = 'Missed';
        subtitleText = 'Due on ${DateFormat('yyyy-MM-dd').format(nextDueDate)}'; // Format this date as needed
        break;
      case VaccineStatus.upcoming:
        statusColor = Colors.white;
        int daysLeft = nextDueDate.difference(DateTime.now()).inDays;
        statusText = '$daysLeft days left';
        subtitleText = 'Due on ${DateFormat('yyyy-MM-dd').format(nextDueDate)}'; // Format this date as needed
        break;
      default:
        statusColor = Colors.white;
        statusText = '';
        subtitleText = '';
    }

    return Card(
      color: statusColor,
      child: ListTile(
        title: Text(vaccine.name),
        subtitle: Text(subtitleText), // Updated subtitle
        trailing: Text(
          statusText,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
