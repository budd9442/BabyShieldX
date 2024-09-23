import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<Event>> _events;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _events = {};
  }

  List<Event> _getEventsForDay(DateTime date) {
    return _events[date] ?? [];
  }

  List<Event> _getAllEvents() {
    return _events.values.expand((events) => events).toList();
  }

  void _addEventPopup() {
    final TextEditingController _babyNameController = TextEditingController();
    final TextEditingController _vaccineTypeController = TextEditingController();
    DateTime _eventDate = DateTime.now();
    Color _selectedColor = Color(0xFFdbdcff);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    TextField(
                      controller: _babyNameController,
                      decoration: InputDecoration(labelText: "Baby's Name"),
                    ),
                    TextField(
                      controller: _vaccineTypeController,
                      decoration: InputDecoration(labelText: "Vaccination Type"),
                    ),
                    ListTile(
                      title: Text('Select Date'),
                      subtitle: Text("${_eventDate.toLocal()}".split(' ')[0]),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _eventDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _eventDate = pickedDate;
                          });
                        }
                      },
                    ),
                    DropdownButton<Color>(
                      value: _selectedColor,
                      items: const [
                        DropdownMenuItem(
                          value: Color(0xFFdbdcff),
                          child: Text('Blue', style: TextStyle(color: Color(0xFFdbdcff))),
                        ),
                        DropdownMenuItem(
                          value: Color(0xFFffd4e5),
                          child: Text('Pink', style: TextStyle(color: Color(0xFFffd4e5))),
                        ),
                        DropdownMenuItem(
                          value: Color(0xFFbaffc9),
                          child: Text('Green', style: TextStyle(color: Color(0xFFbaffc9))),
                        ),
                      ],
                      onChanged: (Color? color) {
                        setState(() {
                          _selectedColor = color!;
                        });
                      },
                      hint: Text('Select a color'),
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_babyNameController.text.isNotEmpty &&
                    _vaccineTypeController.text.isNotEmpty) {
                  setState(() {
                    if (_events[_eventDate] != null) {
                      _events[_eventDate]!.add(Event(
                        title:
                        "${_babyNameController.text}'s vaccine: ${_vaccineTypeController.text}",
                        color: _selectedColor,
                        babyName: _babyNameController.text,
                        vaccineType: _vaccineTypeController.text,
                        dateTime: _eventDate,
                      ));
                    } else {
                      _events[_eventDate] = [
                        Event(
                          title:
                          "${_babyNameController.text}'s vaccine: ${_vaccineTypeController.text}",
                          color: _selectedColor,
                          babyName: _babyNameController.text,
                          vaccineType: _vaccineTypeController.text,
                          dateTime: _eventDate,
                        )
                      ];
                    }
                  });
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
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
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(
                formatButtonVisible : false,
                titleCentered: true
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
            ElevatedButton(
              onPressed: _addEventPopup,
              child: Text('Add Event'),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _getAllEvents().length,
                itemBuilder: (context, index) {
                  final event = _getAllEvents()[index];
                  return Card(

                    color: event.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),),
                    ),
                    margin: EdgeInsets.only(right: 20,bottom: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage('assets/baby_placeholder.png'), // Add a placeholder image
                              ),
                              SizedBox(height: 8.0,width: 10,),
                              Column(
                                children: [
                                  Text(
                                    "${DateFormat.MMM().format(event.dateTime)} ${event.dateTime.month} ${event.dateTime.year}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    DateFormat('hh:mm a').format(event.dateTime),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              )

                            ],
                          ),

                          Container(
                            height: 50, // Ensure this height is appropriate for your layout
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

  Event({
    required this.title,
    required this.color,
    required this.babyName,
    required this.vaccineType,
    required this.dateTime,
  });

  @override
  String toString() => title;
}
