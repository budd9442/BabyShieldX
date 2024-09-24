import 'package:flutter/material.dart';
import 'models/models.dart'; // Assuming models.dart contains the Child and Vaccine models

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

  @override
  void initState() {
    super.initState();
    _selectedChildIndex = widget.initialIndex;
    _currentChild = widget.children[_selectedChildIndex];
  }

  void _switchChild(int index) {
    setState(() {
      _selectedChildIndex = index;
      _currentChild = widget.children[_selectedChildIndex];
      _searchQuery = ''; // Reset search query when switching children
    });
  }

  List<Vaccine> get _filteredVaccines {
    if (_searchQuery.isEmpty) {
      return _currentChild.vaccines;
    }
    return _currentChild.vaccines
        .where((vaccine) =>
        vaccine.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccine Schedule'),
        backgroundColor: Color(0xFF52C6A9),
      ),
      body: Column(
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

    switch (vaccine.status) {
      case VaccineStatus.completed:
        statusColor = Colors.green[100]!;
        statusText = 'completed';
        break;
      case VaccineStatus.delayed:
        statusColor = Colors.red[100]!;
        statusText = 'delayed by ${vaccine.delayedBy.inDays} days';
        break;
      case VaccineStatus.missed:
        statusColor = Colors.red[300]!;
        statusText = 'missed';
        break;
      case VaccineStatus.upcoming:
        statusColor = Colors.white;
        statusText = 'upcoming in ${vaccine.daysUntilDue} days';
        break;
      default:
        statusColor = Colors.white;
        statusText = '';
    }

    return Card(
      color: statusColor,
      child: ListTile(
        title: Text(vaccine.name),
        subtitle: Text('${vaccine.dueInMonths} months'),
        trailing: Text(
          statusText,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
