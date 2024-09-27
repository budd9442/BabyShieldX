import 'package:babyshieldx/models/child_provider.dart';
import 'package:babyshieldx/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<Event>> _events;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  List<Event> _upcomingVaccinations = [];
  bool _isLoading = true; // Loading state

  int _calculateDaysLeft(DateTime date) {
    final today = DateTime.now();
    final difference = date.difference(today);
    return difference.inDays; // Return the number of days left
  }

  @override
  void initState() {
    super.initState();
    _events = {};
    _fetchVaccinationTypes();
  }

  // Fetch vaccination types from Supabase
  Future<void> _fetchVaccinationTypes() async {
    try {
      final data = await Supabase.instance.client.from('vaccination_types').select();
      if (data.isNotEmpty) {
        final childrenProvider = Provider.of<ChildrenProvider>(context, listen: false);
        List<Child> children = childrenProvider.children;

        for (var child in children) {
          for (var vaccine in data) {
            DateTime nextVaccinationDate = _calculateNextVaccinationDate(child.dateOfBirth, vaccine['months'], vaccine['years']);

            if (nextVaccinationDate.isAfter(DateTime.now())) {
              _upcomingVaccinations.add(Event(
                profileImage: child.profileImage,
                title: "${child.name}'s ${vaccine['name']}",
                color: child.gender == 'Female'
                    ? Colors.pinkAccent.shade100
                    : Colors.lightBlueAccent.shade100,
                babyName: child.name,
                vaccineType: vaccine['name'],
                dateTime: nextVaccinationDate,
              ));
            }
          }
        }

        _upcomingVaccinations.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Sort by date
      }
    } catch (e) {
      print('An exception occurred: $e');
    } finally {
      setState(() {
        _isLoading = false; // Update loading state
      });
    }
  }

  DateTime _calculateNextVaccinationDate(DateTime birthDate, int months, int years) {
    return DateTime(birthDate.year + years, birthDate.month + months, birthDate.day);
  }

  List<Event> _getEventsForDay(DateTime date) {
    return _events[date] ?? [];
  }

  List<Event> _getAllEvents() {
    return _upcomingVaccinations; // Return upcoming vaccinations instead of _events
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF52C6A9),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vaccination Calendar',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF52C6A9),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)
            )
        ),
        child: Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDate,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              eventLoader: _getEventsForDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDate = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: _isLoading // Show loading indicator while fetching data
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _getAllEvents().length,
                itemBuilder: (context, index) {
                  final event = _getAllEvents()[index];
                  final daysLeft = _calculateDaysLeft(event.dateTime);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = event.dateTime;
                        _focusedDate = event.dateTime;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20, bottom: 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            event.color.withOpacity(0.5),
                            event.color.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(event.profileImage),
                                ),
                                SizedBox(height: 8.0, width: 10),
                                Column(
                                  children: [
                                    Text(
                                      "${DateFormat.MMM().format(event.dateTime)} ${event.dateTime.day}, ${event.dateTime.year}",
                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                    Text(
                                      "$daysLeft days left",
                                      style: TextStyle(fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              child: const VerticalDivider(
                                thickness: 1,
                                width: 30,
                                color: Colors.black12,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${event.babyName}'s vaccination",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      event.vaccineType,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
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
}

class Event {
  final String title;
  final Color color;
  final String babyName;
  final String vaccineType;
  final DateTime dateTime;
  final String profileImage;

  Event({
    required this.title,
    required this.color,
    required this.babyName,
    required this.vaccineType,
    required this.dateTime,
    required this.profileImage,
  });

  @override
  String toString() => title;
}
